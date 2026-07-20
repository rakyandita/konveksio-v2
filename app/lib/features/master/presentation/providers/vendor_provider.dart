import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/vendor_model.dart';
import '../../data/vendor_repository.dart';

final vendorListProvider = AsyncNotifierProvider<VendorListNotifier, List<VendorModel>>(() {
  return VendorListNotifier();
});

class VendorListNotifier extends AsyncNotifier<List<VendorModel>> {
  @override
  Future<List<VendorModel>> build() async {
    return ref.watch(vendorRepositoryProvider).getVendors();
  }

  Future<void> addVendor(VendorModel vendor) async {
    state = const AsyncValue.loading();
    try {
      await ref.read(vendorRepositoryProvider).createVendor(vendor);
      ref.invalidateSelf();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateVendor(VendorModel vendor) async {
    state = const AsyncValue.loading();
    try {
      await ref.read(vendorRepositoryProvider).updateVendor(vendor);
      ref.invalidateSelf();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteVendor(String id) async {
    state = const AsyncValue.loading();
    try {
      await ref.read(vendorRepositoryProvider).deleteVendor(id);
      ref.invalidateSelf();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
