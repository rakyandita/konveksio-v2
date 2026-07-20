import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../domain/cash_advance_model.dart';
import '../domain/salary_record_model.dart';

final financeRepositoryProvider = Provider<FinanceRepository>((ref) {
  return FinanceRepository(Supabase.instance.client);
});

class FinanceRepository {
  final SupabaseClient _supabase;

  FinanceRepository(this._supabase);

  // ================= CASH ADVANCES =================

  Future<double> getKasbonLimit(String userId) async {
    try {
      final response = await _supabase.rpc('get_kasbon_limit', params: {
        'p_user_id': userId,
      });
      if (response != null) {
        return (response as num).toDouble();
      }
      return 0.0;
    } catch (e) {
      throw Exception('Gagal memuat sisa limit kasbon: $e');
    }
  }

  Future<void> submitCashAdvance(CashAdvanceModel request) async {
    try {
      await _supabase.from('cash_advances').insert({
        'branch_id': request.branchId,
        'user_id': request.userId,
        'amount_requested': request.amountRequested,
        'reason': request.reason,
        'status': request.status.name,
      });
    } catch (e) {
      throw Exception('Gagal mengajukan kasbon: $e');
    }
  }

  Future<List<CashAdvanceModel>> getCashAdvancesForApproval() async {
    try {
      // Because RLS filters by branch, we just select
      final response = await _supabase
          .from('cash_advances')
          .select()
          .eq('status', 'pending')
          .order('created_at', ascending: false);
          
      return (response as List).map((data) => CashAdvanceModel.fromJson(data)).toList();
    } catch (e) {
      throw Exception('Gagal mengambil daftar kasbon: $e');
    }
  }

  Future<List<CashAdvanceModel>> getCashAdvancesForUser(String userId) async {
    try {
      final response = await _supabase
          .from('cash_advances')
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false);
          
      return (response as List).map((data) => CashAdvanceModel.fromJson(data)).toList();
    } catch (e) {
      throw Exception('Gagal mengambil riwayat kasbon: $e');
    }
  }

  Future<void> updateCashAdvanceStatus({
    required String id,
    required ApprovalStatus status,
    double? amountApproved,
    String? rejectionReason,
  }) async {
    try {
      final updateData = <String, dynamic>{
        'status': status.name,
        'approved_at': status != ApprovalStatus.pending ? DateTime.now().toIso8601String() : null,
      };

      if (status == ApprovalStatus.approved) {
        updateData['amount_approved'] = amountApproved;
      } else if (status == ApprovalStatus.rejected) {
        updateData['rejection_reason'] = rejectionReason;
      }

      await _supabase.from('cash_advances').update(updateData).eq('id', id);
    } catch (e) {
      throw Exception('Gagal memperbarui status kasbon: $e');
    }
  }

  // ================= SALARY RECORDS =================

  Future<List<SalaryRecordModel>> getSalaryRecordsForUser(String userId) async {
    try {
      final response = await _supabase
          .from('salary_records')
          .select()
          .eq('user_id', userId)
          .order('period_end', ascending: false);
          
      return (response as List).map((data) => SalaryRecordModel.fromJson(data)).toList();
    } catch (e) {
      throw Exception('Gagal mengambil riwayat gaji: $e');
    }
  }

  Future<List<SalaryRecordModel>> getAllSalaryRecords() async {
    try {
      final response = await _supabase
          .from('salary_records')
          .select()
          .order('period_end', ascending: false);
          
      return (response as List).map((data) => SalaryRecordModel.fromJson(data)).toList();
    } catch (e) {
      throw Exception('Gagal mengambil riwayat gaji: $e');
    }
  }

  Future<Map<String, dynamic>> generateWeeklySalary(String branchId, DateTime periodStart, DateTime periodEnd) async {
    try {
      final response = await _supabase.rpc('generate_weekly_salary', params: {
        'p_branch_id': branchId,
        'p_period_start': periodStart.toIso8601String().split('T')[0],
        'p_period_end': periodEnd.toIso8601String().split('T')[0],
      });
      return response as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Gagal membuat catatan gaji mingguan: $e');
    }
  }
}
