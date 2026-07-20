import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../domain/cash_advance_model.dart';
import '../data/finance_repository.dart';

class BossKasbonApprovalState {
  final bool isLoading;
  final String? error;
  final List<CashAdvanceModel> pendingRequests;

  BossKasbonApprovalState({
    this.isLoading = false,
    this.error,
    this.pendingRequests = const [],
  });

  BossKasbonApprovalState copyWith({
    bool? isLoading,
    String? error,
    List<CashAdvanceModel>? pendingRequests,
  }) {
    return BossKasbonApprovalState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      pendingRequests: pendingRequests ?? this.pendingRequests,
    );
  }
}

class BossKasbonApprovalController extends Notifier<BossKasbonApprovalState> {
  @override
  BossKasbonApprovalState build() {
    // SOT UC-004: Automatically fetch pending requests when initialized
    Future.microtask(() => _fetchPendingRequests());
    return BossKasbonApprovalState();
  }

  Future<void> _fetchPendingRequests() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final supabase = Supabase.instance.client;

      if (supabase.auth.currentUser == null) {
        state = state.copyWith(isLoading: false, error: 'Sesi tidak valid');
        return;
      }

      final requests = await ref.read(financeRepositoryProvider).getCashAdvancesForApproval();
      
      state = state.copyWith(isLoading: false, pendingRequests: requests);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> approveRequest(String id, {double? amountApproved}) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final supabase = Supabase.instance.client;

      if (supabase.auth.currentUser == null) {
        state = state.copyWith(isLoading: false, error: 'Sesi tidak valid');
        return;
      }

      await ref.read(financeRepositoryProvider).updateCashAdvanceStatus(
        id: id,
        status: ApprovalStatus.approved,
        amountApproved: amountApproved,
      );
      
      final updatedRequests = state.pendingRequests.where((req) => req.id != id).toList();
      state = state.copyWith(isLoading: false, pendingRequests: updatedRequests);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> rejectRequest(String id, String? rejectionReason) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final supabase = Supabase.instance.client;

      if (supabase.auth.currentUser == null) {
        state = state.copyWith(isLoading: false, error: 'Sesi tidak valid');
        return;
      }

      await ref.read(financeRepositoryProvider).updateCashAdvanceStatus(
        id: id,
        status: ApprovalStatus.rejected,
        rejectionReason: rejectionReason,
      );
      
      final updatedRequests = state.pendingRequests.where((r) => r.id != id).toList();
      state = state.copyWith(isLoading: false, pendingRequests: updatedRequests);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

final bossKasbonApprovalControllerProvider =
    NotifierProvider<BossKasbonApprovalController, BossKasbonApprovalState>(() {
  return BossKasbonApprovalController();
});
