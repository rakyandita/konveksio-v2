import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../domain/salary_record_model.dart';
import '../data/finance_repository.dart';

final karyawanSalaryControllerProvider =
    FutureProvider.autoDispose<List<SalaryRecordModel>>((ref) async {
  final supabase = Supabase.instance.client;
  
  if (supabase.auth.currentUser == null) {
    return [];
  }

  return ref.read(financeRepositoryProvider).getSalaryRecordsForUser(supabase.auth.currentUser!.id);
});
