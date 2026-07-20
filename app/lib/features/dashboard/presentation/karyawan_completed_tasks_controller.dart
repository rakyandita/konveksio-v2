import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CompletedTaskItem {
  final String handoverId;
  final String orderItemId;
  final String productName;
  final String? customerName;
  final DateTime completedAt;
  final String handedOverTo;
  final Map<String, int> handoverSizes;

  CompletedTaskItem({
    required this.handoverId,
    required this.orderItemId,
    required this.productName,
    this.customerName,
    required this.completedAt,
    required this.handedOverTo,
    required this.handoverSizes,
  });

  factory CompletedTaskItem.fromJson(Map<String, dynamic> json) {
    final sizes = <String, int>{};
    final sizesList = json['handover_sizes'] as List<dynamic>? ?? [];
    for (var sizeData in sizesList) {
      final size = sizeData['size'] as String;
      sizes[size] = (sizeData['qty_received'] ?? sizeData['qty_sent']) as int;
    }

    final fromTask = json['tasks'] ?? {};
    final orderItem = fromTask['order_items'] ?? {};
    final order = orderItem['orders'] ?? {};
    final customer = order['customers'] ?? {};
    final product = orderItem['products'] ?? {};
    
    String toName = 'Selesai';
    if (json['to_user'] != null && json['to_user']['name'] != null) {
      toName = json['to_user']['name'];
    } else if (json['to_vendor'] != null && json['to_vendor']['name'] != null) {
      toName = json['to_vendor']['name'];
    }

    return CompletedTaskItem(
      handoverId: json['id'] as String,
      orderItemId: orderItem['id'] as String? ?? '',
      productName: product['name'] as String? ?? 'Pesanan',
      customerName: customer['name'] as String?,
      completedAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : DateTime.now(),
      handedOverTo: toName,
      handoverSizes: sizes,
    );
  }

  int get totalQty {
    return handoverSizes.values.fold(0, (sum, val) => sum + val);
  }
}

class KaryawanCompletedTasksController extends AsyncNotifier<List<CompletedTaskItem>> {
  @override
  Future<List<CompletedTaskItem>> build() async {
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
            created_at,
            handover_sizes (size, qty_sent, qty_received),
            to_user:profiles!handovers_to_user_id_fkey (name),
            to_vendor:vendors!handovers_to_vendor_id_fkey (name),
            tasks!inner (
              assigned_to_user,
              order_items (
                id,
                products (name),
                orders (
                  customers (name)
                )
              )
            )
          ''')
          .eq('tasks.assigned_to_user', user.id)
          .eq('status', 'accepted')
          .order('created_at', ascending: false);

      final List<dynamic> data = response;
      return data.map((json) => CompletedTaskItem.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Gagal memuat tugas selesai: $e');
    }
  }
}

final karyawanCompletedTasksControllerProvider =
    AsyncNotifierProvider<KaryawanCompletedTasksController, List<CompletedTaskItem>>(
  () => KaryawanCompletedTasksController(),
);
