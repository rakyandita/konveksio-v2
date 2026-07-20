import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/order_model.dart';
import '../../data/order_repository.dart';

final orderListProvider = AsyncNotifierProvider<OrderListNotifier, List<OrderModel>>(() {
  return OrderListNotifier();
});

class OrderListNotifier extends AsyncNotifier<List<OrderModel>> {
  @override
  Future<List<OrderModel>> build() async {
    return ref.watch(orderRepositoryProvider).getOrders();
  }

  Future<void> createOrder(Map<String, dynamic> payload) async {
    state = const AsyncValue.loading();
    try {
      await ref.read(orderRepositoryProvider).createOrderTransaction(payload);
      ref.invalidateSelf();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
