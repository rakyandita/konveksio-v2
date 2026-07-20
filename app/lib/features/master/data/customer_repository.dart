import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/supabase/supabase_client_provider.dart';
import '../domain/customer_model.dart';

final customerRepositoryProvider = Provider<CustomerRepository>((ref) {
  return CustomerRepository(ref.watch(supabaseClientProvider));
});

class CustomerRepository {
  final SupabaseClient _supabase;

  CustomerRepository(this._supabase);

  Future<List<CustomerModel>> getCustomers() async {
    final response = await _supabase.from('customers').select().eq('is_active', true).order('name');
    return response.map((json) => CustomerModel.fromJson(json)).toList();
  }

  Future<CustomerModel> createCustomer(CustomerModel customer) async {
    final data = customer.toJson()..remove('id');
    final response = await _supabase.from('customers').insert(data).select().single();
    return CustomerModel.fromJson(response);
  }

  Future<CustomerModel> updateCustomer(CustomerModel customer) async {
    final response = await _supabase
        .from('customers')
        .update(customer.toJson())
        .eq('id', customer.id)
        .select()
        .single();
    return CustomerModel.fromJson(response);
  }

  Future<void> deleteCustomer(String id) async {
    await _supabase.from('customers').update({'is_active': false}).eq('id', id);
  }
}
