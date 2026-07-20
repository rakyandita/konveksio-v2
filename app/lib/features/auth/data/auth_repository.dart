import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;
import '../domain/auth_state.dart';

import '../../core/supabase/supabase_client_provider.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.watch(supabaseClientProvider));
});

class AuthRepository {
  final SupabaseClient _supabase;

  AuthRepository(this._supabase);

  /// Sign in using phone and PIN (password)
  Future<AuthState> signIn(String phone, String pin) async {
    try {
      // 1. Authenticate via Supabase Auth
      // Add fake email domain to phone number since Supabase expects email format
      // if phone login is not natively configured or if we use standard email/pass.
      // Wait, SoT sys_uc_000.md says: signInWithPassword({ phone, password: pin })
      // If we use standard phone auth: 
      final authResponse = await _supabase.auth.signInWithPassword(
        phone: phone,
        password: pin,
      );

      final user = authResponse.user;
      if (user == null) {
        return const AuthState(errorMessage: 'Kredensial tidak valid');
      }

      // 2. Fetch Profile Role from database
      final profileData = await _supabase
          .from('profiles')
          .select('role, branch_id')
          .eq('id', user.id)
          .single();

      final roleString = profileData['role'] as String?;
      final branchId = profileData['branch_id'] as String?;

      UserRole userRole = UserRole.unknown;
      if (roleString != null) {
        switch (roleString.toLowerCase()) {
          case 'owner':
            userRole = UserRole.owner;
            break;
          case 'boss':
            userRole = UserRole.boss;
            break;
          case 'admin':
            userRole = UserRole.admin;
            break;
          case 'employee':
            userRole = UserRole.employee;
            break;
        }
      }

      return AuthState(
        isAuthenticated: true,
        role: userRole,
        branchId: branchId,
      );
    } on AuthException catch (_) {
      // Generic error per Acceptance Criteria
      return const AuthState(errorMessage: 'Nomor HP atau PIN salah.');
    } on PostgrestException catch (e) {
      if (e.code == 'PGRST116') {
        return const AuthState(errorMessage: 'Profil Anda belum dikonfigurasi admin');
      }
      return const AuthState(errorMessage: 'Terjadi kesalahan sistem.');
    } catch (_) {
      return const AuthState(errorMessage: 'Nomor HP atau PIN salah.');
    }
  }

  /// Sign out
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  /// Check current session on startup
  Future<AuthState?> checkSession() async {
    final session = _supabase.auth.currentSession;
    final user = session?.user;
    
    if (session != null && user != null) {
      try {
        final profileData = await _supabase
            .from('profiles')
            .select('role, branch_id')
            .eq('id', user.id)
            .single();

        final roleString = profileData['role'] as String?;
        final branchId = profileData['branch_id'] as String?;

        UserRole userRole = UserRole.unknown;
        if (roleString != null) {
          switch (roleString.toLowerCase()) {
            case 'owner': userRole = UserRole.owner; break;
            case 'boss': userRole = UserRole.boss; break;
            case 'admin': userRole = UserRole.admin; break;
            case 'employee': userRole = UserRole.employee; break;
          }
        }

        return AuthState(
          isAuthenticated: true,
          role: userRole,
          branchId: branchId,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }
}
