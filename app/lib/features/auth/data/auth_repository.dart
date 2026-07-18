import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(Supabase.instance.client);
});

class AuthRepository {
  final SupabaseClient _supabase;

  AuthRepository(this._supabase);

  Future<void> signInWithPhone(String phone, String pin) async {
    // Di V1 Konveksio, kita akan memodelkan PIN sebagai password di Auth Supabase
    // Karena Supabase by default menggunakan Email/Password. 
    // Format email dummy: {phone}@konveksio.local
    
    // Normalisasi nomor telepon
    String normalizedPhone = phone.replaceAll(RegExp(r'\D'), '');
    if (normalizedPhone.startsWith('0')) {
      normalizedPhone = '62${normalizedPhone.substring(1)}';
    }
    
    final dummyEmail = '$normalizedPhone@konveksio.local';
    
    try {
      await _supabase.auth.signInWithPassword(
        email: dummyEmail,
        password: pin,
      );
    } catch (e) {
      throw Exception('Gagal login. Periksa kembali nomor HP dan PIN Anda.');
    }
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }
}
