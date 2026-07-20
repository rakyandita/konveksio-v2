import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/customer_model.dart';
import '../../data/customer_repository.dart';

final customerListProvider = AsyncNotifierProvider<CustomerListNotifier, List<CustomerModel>>(() {
  return CustomerListNotifier();
});

class CustomerListNotifier extends AsyncNotifier<List<CustomerModel>> {
  @override
  Future<List<CustomerModel>> build() async {
    return ref.watch(customerRepositoryProvider).getCustomers();
  }

  Future<void> addCustomer(CustomerModel customer) async {
    state = const AsyncValue.loading();
    try {
      await ref.read(customerRepositoryProvider).createCustomer(customer);
      ref.invalidateSelf();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateCustomer(CustomerModel customer) async {
    state = const AsyncValue.loading();
    try {
      await ref.read(customerRepositoryProvider).updateCustomer(customer);
      ref.invalidateSelf();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteCustomer(String id) async {
    state = const AsyncValue.loading();
    try {
      await ref.read(customerRepositoryProvider).deleteCustomer(id);
      ref.invalidateSelf();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
