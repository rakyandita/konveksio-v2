import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SalaryRecord {
  final String id;
  final String date;
  final String periodStartDate;
  final String periodEndDate;
  final int basePay;
  final int pieceRatePay;
  final int deductions;
  final int netPay;

  SalaryRecord({
    required this.id,
    required this.date,
    required this.periodStartDate,
    required this.periodEndDate,
    required this.basePay,
    required this.pieceRatePay,
    required this.deductions,
    required this.netPay,
  });

  factory SalaryRecord.fromJson(Map<String, dynamic> json) {
    return SalaryRecord(
      id: json['id'] as String,
      date: json['date'] as String,
      periodStartDate: json['period_start_date'] as String,
      periodEndDate: json['period_end_date'] as String,
      basePay: json['base_pay'] as int,
      pieceRatePay: json['piece_rate_pay'] as int,
      deductions: json['deductions'] as int,
      netPay: json['net_pay'] as int,
    );
  }
}

final karyawanSalaryControllerProvider =
    FutureProvider.autoDispose<List<SalaryRecord>>((ref) async {
  final supabase = Supabase.instance.client;
  
  if (supabase.auth.currentUser == null) {
    // Mock data bypass for Fase 6
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      SalaryRecord(
        id: 'sal-1',
        date: '20 Okt 2023',
        periodStartDate: '13 Okt',
        periodEndDate: '19 Okt',
        basePay: 500000,
        pieceRatePay: 250000,
        deductions: 50000,
        netPay: 700000,
      ),
      SalaryRecord(
        id: 'sal-2',
        date: '13 Okt 2023',
        periodStartDate: '6 Okt',
        periodEndDate: '12 Okt',
        basePay: 500000,
        pieceRatePay: 300000,
        deductions: 0,
        netPay: 800000,
      ),
    ];
  }

  // Real Database Query (Fase 7)
  final response = await supabase
      .from('salary_records')
      .select()
      .eq('user_id', supabase.auth.currentUser!.id)
      .order('date', ascending: false);

  return (response as List).map((json) => SalaryRecord.fromJson(json)).toList();
});
