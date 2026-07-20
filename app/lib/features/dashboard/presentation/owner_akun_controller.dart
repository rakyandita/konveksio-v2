import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OwnerAkunState {
  final bool isLoading;
  final String? error;
  final List<Map<String, dynamic>> profiles;

  OwnerAkunState({
    this.isLoading = false,
    this.error,
    this.profiles = const [],
  });

  OwnerAkunState copyWith({
    bool? isLoading,
    String? error,
    List<Map<String, dynamic>>? profiles,
  }) {
    return OwnerAkunState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      profiles: profiles ?? this.profiles,
    );
  }
}

class OwnerAkunController extends Notifier<OwnerAkunState> {
  @override
  OwnerAkunState build() {
    Future.microtask(() => loadProfiles());
    return OwnerAkunState();
  }

  Future<void> loadProfiles() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final supabase = Supabase.instance.client;
      // Ambil daftar user dan cabangnya (jika ada)
      final response = await supabase
          .from('profiles')
          .select('id, name, role, is_active, branch_id, branches(name)')
          .order('name');
      
      // Untuk email, Supabase tidak mengizinkan read auth.users langsung tanpa auth admin API.
      // Kita tambahkan email palsu atau ambil dari profiles jika kita mau menyimpan email di profiles.
      // Karena SRS dan skema 'profiles' tidak ada kolom email, kita set default atau biarkan null.

      state = state.copyWith(isLoading: false, profiles: List<Map<String, dynamic>>.from(response));
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // Pembuatan akun baru butuh Admin API (karena kita tidak ingin Owner ter-logout jika pakai signUp client-side).
  // Sebagai workaround di frontend, kita beri pesan error jika tidak ada Edge Function.
}

final ownerAkunControllerProvider = NotifierProvider<OwnerAkunController, OwnerAkunState>(() {
  return OwnerAkunController();
});
