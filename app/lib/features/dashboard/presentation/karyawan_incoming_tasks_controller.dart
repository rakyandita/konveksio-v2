import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class IncomingTaskItem {
  final String handoverId;
  final String orderItemId;
  final String fromDivision;
  final String productName;
  final String? customerName;
  final Map<String, int> handoverSizes; // size -> qty_sent

  IncomingTaskItem({
    required this.handoverId,
    required this.orderItemId,
    required this.fromDivision,
    required this.productName,
    this.customerName,
    required this.handoverSizes,
  });

  factory IncomingTaskItem.fromJson(Map<String, dynamic> json) {
    final sizes = <String, int>{};
    final sizesList = json['handover_sizes'] as List<dynamic>? ?? [];
    for (var sizeData in sizesList) {
      final size = sizeData['size'] as String;
      sizes[size] = sizeData['qty_sent'] as int;
    }

    final fromTask = json['tasks'] ?? {};
    final orderItem = fromTask['order_items'] ?? {};
    final order = orderItem['orders'] ?? {};
    final product = orderItem['products'] ?? {};

    return IncomingTaskItem(
      handoverId: json['id'] as String,
      orderItemId: orderItem['id'] as String? ?? '',
      fromDivision: fromTask['division'] as String? ?? 'Divisi Sebelumnya',
      productName: product['name'] as String? ?? 'Pesanan',
      customerName: order['customer_name'] as String?,
      handoverSizes: sizes,
    );
  }

  int get totalQty {
    return handoverSizes.values.fold(0, (sum, val) => sum + val);
  }
}

final karyawanIncomingTasksControllerProvider =
    FutureProvider.autoDispose<List<IncomingTaskItem>>((ref) async {
  final supabase = Supabase.instance.client;
  final user = supabase.auth.currentUser;

  if (user == null) {
    return [];
  }

  try {
    final response = await supabase
        .from('handovers')
        .select('''
          id,
          status,
          handover_sizes (size, qty_sent),
          tasks!handovers_from_task_id_fkey (
            division,
            order_items (
              id,
              products (name),
              orders (customer_name)
            )
          )
        ''')
        .eq('to_user_id', user.id)
        .eq('status', 'pending')
        .order('created_at', ascending: false);

    final List<dynamic> data = response;
    return data.map((json) => IncomingTaskItem.fromJson(json)).toList();
  } catch (e) {
    throw Exception('Gagal memuat tugas masuk: $e');
  }
});
