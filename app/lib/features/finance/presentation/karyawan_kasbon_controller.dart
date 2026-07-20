import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../auth/presentation/auth_controller.dart';
import '../../../core/utils/mock_data.dart';
import '../domain/cash_advance_model.dart';
import '../data/finance_repository.dart';

final kasbonLimitProvider = FutureProvider.autoDispose<double>((ref) async {
  final supabase = Supabase.instance.client;
  final authState = ref.watch(authControllerProvider);
  
  if (!authState.isAuthenticated || supabase.auth.currentUser == null) return 0.0;
  
  return ref.read(financeRepositoryProvider).getKasbonLimit(supabase.auth.currentUser!.id);
});

final kasbonHistoryProvider = FutureProvider.autoDispose<List<CashAdvanceModel>>((ref) async {
  final supabase = Supabase.instance.client;
  final authState = ref.watch(authControllerProvider);
  
  if (!authState.isAuthenticated || supabase.auth.currentUser == null) return [];
  
  return ref.read(financeRepositoryProvider).getCashAdvancesForUser(supabase.auth.currentUser!.id);
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
      
      if (supabase.auth.currentUser == null) {
        state = state.copyWith(isLoading: false, error: 'Sesi tidak valid');
        return;
      }

      // Alur normal Supabase
      if (!authState.isAuthenticated) {
        throw Exception('Sesi tidak valid: Belum login (isAuthenticated=false).');
      }

      // BYPASS UNTUK TESTING (Fallback branch_id)
      String? targetBranchId = authState.branchId;
      if (targetBranchId == null) {
        final branchData = await supabase.from('branches').select('id').limit(1).single();
        targetBranchId = branchData['id'] as String;
      }

      await ref.read(financeRepositoryProvider).submitCashAdvance(
        CashAdvanceModel(
          id: '',
          branchId: targetBranchId,
          userId: supabase.auth.currentUser!.id,
          amountRequested: amount,
          reason: reason,
          status: ApprovalStatus.pending,
          createdAt: DateTime.now(),
        )
      );

      // Invalidate providers
      ref.invalidate(kasbonLimitProvider);
      ref.invalidate(kasbonHistoryProvider);
      
      state = state.copyWith(isLoading: false, isSuccess: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

final karyawanKasbonControllerProvider = NotifierProvider<KaryawanKasbonController, KasbonState>(() {
  return KaryawanKasbonController();
});

