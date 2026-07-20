import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/supabase/supabase_client_provider.dart';
import '../../auth/domain/user_model.dart';
import '../domain/employee_rate_model.dart';

final employeeRepositoryProvider = Provider<EmployeeRepository>((ref) {
  return EmployeeRepository(ref.watch(supabaseClientProvider));
});

class EmployeeRepository {
  final SupabaseClient _supabase;

  EmployeeRepository(this._supabase);

  Future<List<UserModel>> getEmployees() async {
    final response = await _supabase
        .from('profiles')
        .select()
        .eq('role', 'employee')
        .eq('is_active', true)
        .order('name');
    return response.map((json) => UserModel.fromJson(json)).toList();
  }

  Future<List<UserModel>> getAdmins() async {
    final response = await _supabase
        .from('profiles')
        .select()
        .inFilter('role', ['admin', 'boss', 'owner'])
        .eq('is_active', true)
        .order('name');
    return response.map((json) => UserModel.fromJson(json)).toList();
  }

  Future<List<EmployeeRateModel>> getEmployeeRates(String employeeId) async {
    final response = await _supabase
        .from('employee_rates')
        .select()
        .eq('employee_id', employeeId)
        .eq('is_active', true);
    return response.map((json) => EmployeeRateModel.fromJson(json)).toList();
  }

  Future<EmployeeRateModel> createEmployeeRate(EmployeeRateModel rate) async {
    final data = rate.toJson()..remove('id');
    final response = await _supabase.from('employee_rates').insert(data).select().single();
    return EmployeeRateModel.fromJson(response);
  }

  Future<EmployeeRateModel> updateEmployeeRate(EmployeeRateModel rate) async {
    final response = await _supabase
        .from('employee_rates')
        .update(rate.toJson())
        .eq('id', rate.id)
        .select()
        .single();
    return EmployeeRateModel.fromJson(response);
  }

  Future<void> deleteEmployeeRate(String id) async {
    await _supabase.from('employee_rates').update({'is_active': false}).eq('id', id);
  }
}
