import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/cash_advance.dart';

class BossKasbonApprovalState {
  final bool isLoading;
  final String? error;
  final List<CashAdvance> pendingRequests;

  BossKasbonApprovalState({
    this.isLoading = false,
    this.error,
    this.pendingRequests = const [],
  });

  BossKasbonApprovalState copyWith({
    bool? isLoading,
    String? error,
    List<CashAdvance>? pendingRequests,
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
      // SOT UC-004: Fetch pending cash advance requests
      await Future.delayed(const Duration(seconds: 1));
      
      final mockRequests = [
        CashAdvance(
          id: 'ca-1',
          branchId: 'branch-1',
          userId: 'Karyawan 1', // Placeholder for user name
          amountRequested: 100000,
          reason: 'Kebutuhan Harian',
          status: ApprovalStatus.pending,
          createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        ),
        CashAdvance(
          id: 'ca-2',
          branchId: 'branch-1',
          userId: 'Karyawan 2', 
          amountRequested: 250000,
          reason: 'Sekolah Anak',
          status: ApprovalStatus.pending,
          createdAt: DateTime.now().subtract(const Duration(hours: 5)),
        ),
        CashAdvance(
          id: 'ca-3',
          branchId: 'branch-1',
          userId: 'Karyawan 3',
          amountRequested: 50000,
          reason: 'Kesehatan',
          status: ApprovalStatus.pending,
          createdAt: DateTime.now().subtract(const Duration(days: 1)),
        ),
      ];
      
      state = state.copyWith(isLoading: false, pendingRequests: mockRequests);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> approveRequest(String id, {double? amountApproved}) async {
    try {
      // Dummy logic for now. Replace with actual Supabase RPC/DB update.
      // e.g. await supabase.from('cash_advances').update({'status': 'approved', 'amount_approved': amountApproved}).eq('id', id);
      
      final updatedRequests = state.pendingRequests.where((req) => req.id != id).toList();
      state = state.copyWith(pendingRequests: updatedRequests);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> rejectRequest(String id, String? rejectionReason) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      // SOT UC-004: Reject logic
      // supabase.from('cash_advances').update({ status: 'rejected' }).eq('id', id)
      await Future.delayed(const Duration(seconds: 1));
      
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
