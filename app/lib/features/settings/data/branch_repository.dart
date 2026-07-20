import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../domain/branch_setting_model.dart';

final branchRepositoryProvider = Provider<BranchRepository>((ref) {
  return BranchRepository(Supabase.instance.client);
});

class BranchRepository {
  final SupabaseClient _supabase;

  BranchRepository(this._supabase);

  Future<BranchSettingModel?> getBranchSetting(String branchId) async {
    try {
      final response = await _supabase
          .from('branch_settings')
          .select()
          .eq('branch_id', branchId)
          .maybeSingle();
      
      if (response == null) return null;
      return BranchSettingModel.fromJson(response);
    } catch (e) {
      throw Exception('Gagal mengambil pengaturan cabang: $e');
    }
  }

  Future<void> updateBranchSetting(BranchSettingModel setting) async {
    try {
      await _supabase.from('branch_settings').upsert({
        'branch_id': setting.branchId,
        'payment_system': setting.paymentSystem,
        'max_kasbon_percentage': setting.maxKasbonPercentage,
        'contact_wa': setting.contactWa,
        'bank_account_info': setting.bankAccountInfo,
      });
    } catch (e) {
      throw Exception('Gagal memperbarui pengaturan cabang: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getBranches() async {
    try {
      // Used by Owner to select acting branch
      final response = await _supabase.from('branches').select('id, name, address, is_active').eq('is_active', true);
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      throw Exception('Gagal mengambil daftar cabang: $e');
    }
  }
}
