import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/utils/mock_data.dart';
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
      final supabase = Supabase.instance.client;

      // BYPASS MOCK UNTUK PENGUJIAN VISUAL
      if (supabase.auth.currentUser == null) {
        final pending = MockData.cashAdvances
            .where((e) => e.status == ApprovalStatus.pending)
            .toList();
        // Sort descending by date
        pending.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        
        state = state.copyWith(isLoading: false, pendingRequests: pending);
        return;
      }

      final response = await supabase
          .from('cash_advances')
          .select('*, profiles:user_id(full_name)')
          .eq('status', 'pending')
          .order('created_at', ascending: false);
      
      final List<dynamic> data = response;
      final requests = data.map((json) {
        final profile = json['profiles'] as Map<String, dynamic>?;
        final name = profile != null ? profile['full_name'] as String? ?? 'Karyawan' : 'Karyawan';
        return CashAdvance(
          id: json['id'] as String,
          branchId: json['branch_id'] as String,
          userId: name, // We store the full_name here for UI display
          amountRequested: (json['amount_requested'] as num).toDouble(),
          amountApproved: json['amount_approved'] != null ? (json['amount_approved'] as num).toDouble() : null,
          reason: json['reason'] as String?,
          status: ApprovalStatus.values.firstWhere(
            (e) => e.name == json['status'],
            orElse: () => ApprovalStatus.pending,
          ),
          createdAt: DateTime.parse(json['created_at'].toString()),
          approvedAt: json['approved_at'] != null ? DateTime.parse(json['approved_at'].toString()) : null,
          rejectionReason: json['rejection_reason'] as String?,
        );
      }).toList();
      
      state = state.copyWith(isLoading: false, pendingRequests: requests);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> approveRequest(String id, {double? amountApproved}) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final supabase = Supabase.instance.client;

      // BYPASS MOCK UNTUK PENGUJIAN VISUAL
      if (supabase.auth.currentUser == null) {
        final index = MockData.cashAdvances.indexWhere((e) => e.id == id);
        if (index != -1) {
          final old = MockData.cashAdvances[index];
          MockData.cashAdvances[index] = CashAdvance(
            id: old.id,
            branchId: old.branchId,
            userId: old.userId,
            amountRequested: old.amountRequested,
            amountApproved: amountApproved ?? old.amountRequested,
            reason: old.reason,
            status: ApprovalStatus.approved,
            createdAt: old.createdAt,
            approvedAt: DateTime.now(),
          );
        }
        await _fetchPendingRequests();
        return;
      }

      await supabase.from('cash_advances').update({
        'status': 'approved',
        'amount_approved': amountApproved,
        'approved_at': DateTime.now().toIso8601String(),
      }).eq('id', id);
      
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

      // BYPASS MOCK UNTUK PENGUJIAN VISUAL
      if (supabase.auth.currentUser == null) {
        final index = MockData.cashAdvances.indexWhere((e) => e.id == id);
        if (index != -1) {
          final old = MockData.cashAdvances[index];
          MockData.cashAdvances[index] = CashAdvance(
            id: old.id,
            branchId: old.branchId,
            userId: old.userId,
            amountRequested: old.amountRequested,
            reason: old.reason,
            status: ApprovalStatus.rejected,
            createdAt: old.createdAt,
            rejectionReason: rejectionReason,
          );
        }
        await _fetchPendingRequests();
        return;
      }

      await supabase.from('cash_advances').update({
        'status': 'rejected',
        'rejection_reason': rejectionReason,
      }).eq('id', id);
      
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
