import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TaskItem {
  final String id;
  final String orderItemId;
  final String status; // running, completed
  final String productName;
  final String? customerName;
  final DateTime? deadlineDate;
  final Map<String, int> targets; // size -> target_qty
  final Map<String, int> completed; // size -> completed_qty

  TaskItem({
    required this.id,
    required this.orderItemId,
    required this.status,
    required this.productName,
    this.customerName,
    this.deadlineDate,
    required this.targets,
    required this.completed,
  });

  factory TaskItem.fromJson(Map<String, dynamic> json) {
    final targets = <String, int>{};
    final completed = <String, int>{};
    
    final sizesList = json['task_sizes'] as List<dynamic>? ?? [];
    for (var sizeData in sizesList) {
      final size = sizeData['size'] as String;
      targets[size] = sizeData['target_qty'] as int;
      completed[size] = sizeData['completed_qty'] as int;
    }

    final orderItem = json['order_items'] ?? {};
    final order = orderItem['orders'] ?? {};
    final product = orderItem['products'] ?? {};

    return TaskItem(
      id: json['id'] as String,
      orderItemId: json['order_item_id'] as String,
      status: json['status'] as String,
      productName: product['name'] as String? ?? 'Pesanan',
      customerName: order['customer_name'] as String?,
      deadlineDate: order['deadline_date'] != null 
          ? DateTime.tryParse(order['deadline_date'].toString()) 
          : null,
      targets: targets,
      completed: completed,
    );
  }

  int get totalTarget {
    return targets.values.fold(0, (sum, val) => sum + val);
  }

  int get totalCompleted {
    return completed.values.fold(0, (sum, val) => sum + val);
  }
  
  Map<String, int> get remainingTargets {
    final remaining = <String, int>{};
    for (var size in targets.keys) {
      final t = targets[size] ?? 0;
      final c = completed[size] ?? 0;
      if (t - c > 0) {
        remaining[size] = t - c;
      }
    }
    return remaining;
  }
}

final karyawanTasksControllerProvider =
    FutureProvider.autoDispose<List<TaskItem>>((ref) async {
  final supabase = Supabase.instance.client;
  final user = supabase.auth.currentUser;

  if (user == null) {
    // Return mock data for preview/testing when logged out
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      TaskItem(
        id: 'task-mock-1',
        orderItemId: 'order-item-mock-1',
        status: 'running',
        productName: 'Kemeja Polos Merah (Mock)',
        customerName: 'PT. Maju Mundur',
        deadlineDate: DateTime.now().add(const Duration(days: 2)),
        targets: {'S': 5, 'M': 10, 'L': 2},
        completed: {'S': 0, 'M': 5, 'L': 0},
      ),
    ];
  }

  try {
    final response = await supabase
        .from('tasks')
        .select('''
          *,
          task_sizes (size, target_qty, completed_qty),
          order_items (
            id,
            products (name),
            orders (id, deadline_date, customer_name)
          )
        ''')
        .eq('assigned_to_user', user.id)
        .order('created_at', ascending: false);

    final List<dynamic> data = response;
    return data.map((json) => TaskItem.fromJson(json)).toList();
  } catch (e) {
    // Fallback if schema is incomplete or RLS blocks
    throw Exception('Gagal memuat tugas: $e');
  }
});
