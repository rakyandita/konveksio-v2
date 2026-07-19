import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../auth/presentation/auth_controller.dart';
import '../domain/cash_advance.dart';

final kasbonLimitProvider = FutureProvider.autoDispose<double>((ref) async {
  final supabase = Supabase.instance.client;
  final authState = ref.watch(authControllerProvider);
  
  if (!authState.isAuthenticated || supabase.auth.currentUser == null) return 0.0;
  
  try {
    // Call RPC to get remaining limit
    final response = await supabase.rpc('get_kasbon_limit', params: {
      'p_user_id': supabase.auth.currentUser!.id,
    });
    
    // Parse response
    if (response != null) {
      return (response as num).toDouble();
    }
    return 0.0;
  } catch (e) {
    throw Exception('Gagal memuat sisa limit kasbon: $e');
  }
});

class KasbonState {
  final bool isLoading;
  final String? error;
  final bool isSuccess;

  const KasbonState({
    this.isLoading = false,
    this.error,
    this.isSuccess = false,
  });

  KasbonState copyWith({
    bool? isLoading,
    String? error,
    bool? isSuccess,
  }) {
    return KasbonState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

class KaryawanKasbonController extends Notifier<KasbonState> {
  @override
  KasbonState build() {
    return const KasbonState();
  }

  Future<void> submitKasbon({
    required double amount,
    required String reason,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final supabase = Supabase.instance.client;
      final authState = ref.read(authControllerProvider);
      
      if (!authState.isAuthenticated || authState.branchId == null || supabase.auth.currentUser == null) {
        throw Exception('Sesi tidak valid.');
      }
      
      // Get current limit first to validate double submission
      final limit = await ref.read(kasbonLimitProvider.future);
      if (amount > limit) {
        throw Exception('Nominal melebihi sisa limit Anda.');
      }

      await supabase.from('cash_advances').insert({
        'branch_id': authState.branchId,
        'user_id': supabase.auth.currentUser!.id,
        'amount_requested': amount,
        'reason': reason,
        'status': ApprovalStatus.pending.name,
      });

      // Invalidate the limit provider so it refreshes next time
      ref.invalidate(kasbonLimitProvider);
      
      state = state.copyWith(isLoading: false, isSuccess: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

final karyawanKasbonControllerProvider = NotifierProvider<KaryawanKasbonController, KasbonState>(() {
  return KaryawanKasbonController();
});
