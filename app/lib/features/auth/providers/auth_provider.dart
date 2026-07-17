import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/providers/supabase_provider.dart';
import '../models/user_profile.dart';

final authStateProvider = StreamProvider<AuthState>((ref) {
  final supabase = ref.watch(supabaseProvider);
  return supabase.auth.onAuthStateChange;
});

final userProfileProvider = FutureProvider<UserProfile?>((ref) async {
  final supabase = ref.watch(supabaseProvider);
  final session = supabase.auth.currentSession;
  
  if (session == null) return null;

  try {
    final response = await supabase
        .from('profiles')
        .select('id, role, branch_id')
        .eq('id', session.user.id)
        .single();
        
    return UserProfile.fromJson(response);
  } catch (e) {
    // If profile doesn't exist or PGRST116 (0 rows)
    return null;
  }
});

class AuthController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {
    // No initial loading state needed, it just initializes as AsyncData(null)
  }

  Future<void> login(String phone, String pin) async {
    state = const AsyncLoading();
    try {
      final supabase = ref.read(supabaseProvider);
      await supabase.auth.signInWithPassword(
        phone: phone,
        password: pin,
      );
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }

  Future<void> logout() async {
    state = const AsyncLoading();
    try {
      final supabase = ref.read(supabaseProvider);
      await supabase.auth.signOut();
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final authControllerProvider = AsyncNotifierProvider<AuthController, void>(() {
  return AuthController();
});
