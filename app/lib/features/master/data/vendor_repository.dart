import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/supabase/supabase_client_provider.dart';
import '../domain/vendor_model.dart';

final vendorRepositoryProvider = Provider<VendorRepository>((ref) {
  return VendorRepository(ref.watch(supabaseClientProvider));
});

class VendorRepository {
  final SupabaseClient _supabase;

  VendorRepository(this._supabase);

  Future<List<VendorModel>> getVendors() async {
    final response = await _supabase.from('vendors').select().eq('is_active', true).order('name');
    return response.map((json) => VendorModel.fromJson(json)).toList();
  }

  Future<VendorModel> createVendor(VendorModel vendor) async {
    final data = vendor.toJson()..remove('id');
    final response = await _supabase.from('vendors').insert(data).select().single();
    return VendorModel.fromJson(response);
  }

  Future<VendorModel> updateVendor(VendorModel vendor) async {
    final response = await _supabase
        .from('vendors')
        .update(vendor.toJson())
        .eq('id', vendor.id)
        .select()
        .single();
    return VendorModel.fromJson(response);
  }

  Future<void> deleteVendor(String id) async {
    await _supabase.from('vendors').update({'is_active': false}).eq('id', id);
  }
}
