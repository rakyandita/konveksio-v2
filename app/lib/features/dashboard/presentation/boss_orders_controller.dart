import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../auth/presentation/auth_controller.dart';
import '../../production/data/order_repository.dart';

class OrderItem {
  final String id;
  final String productName;
  final int pricePerPcs;
  final int totalQty;

  OrderItem({
    required this.id,
    required this.productName,
    required this.pricePerPcs,
    required this.totalQty,
  });
}

class Order {
  final String id;
  final String customerName;
  final String status;
  final DateTime deadlineDate;
  final int totalPrice;
  final List<OrderItem> items;

  Order({
    required this.id,
    required this.customerName,
    required this.status,
    required this.deadlineDate,
    required this.totalPrice,
    required this.items,
  });

  // Untuk mock data
  factory Order.mock({
    required String id,
    required String customerName,
    required String status,
    required DateTime deadlineDate,
    required int totalPrice,
  }) {
    return Order(
      id: id,
      customerName: customerName,
      status: status,
      deadlineDate: deadlineDate,
      totalPrice: totalPrice,
      items: [
        OrderItem(id: 'item-1', productName: 'Kemeja PDL', pricePerPcs: 150000, totalQty: 50),
      ],
    );
  }
}

final bossOrdersControllerProvider =
    FutureProvider.autoDispose<List<Order>>((ref) async {
  final supabase = Supabase.instance.client;
  
  if (supabase.auth.currentUser == null) {
    throw Exception('Sesi tidak valid: Belum login');
  }

  final authState = ref.read(authControllerProvider);
  if (authState.branchId == null) {
    throw Exception('Branch ID tidak ditemukan');
  }

  final rawOrders = await ref.read(orderRepositoryProvider).getOrdersWithDetails(authState.branchId!);
  
  return rawOrders.map((json) {
    final itemsList = (json['order_items'] as List?) ?? [];
    final parsedItems = itemsList.map((item) {
      final productInfo = item['products'];
      final sizes = (item['order_item_sizes'] as List?) ?? [];
      
      int totalQty = 0;
      for (var size in sizes) {
        totalQty += (size['qty'] as num?)?.toInt() ?? 0;
      }
      
      return OrderItem(
        id: item['id'] as String,
        productName: productInfo != null ? productInfo['name'] as String : 'Unknown Product',
        pricePerPcs: (item['price_per_pcs'] as num?)?.toInt() ?? 0,
        totalQty: totalQty,
      );
    }).toList();

    final customerInfo = json['customers'];
    
    return Order(
      id: json['id'] as String,
      customerName: customerInfo != null ? customerInfo['name'] as String : 'Unknown Customer',
      status: json['status'] as String? ?? 'draft',
      deadlineDate: json['deadline_date'] != null 
          ? DateTime.parse(json['deadline_date'] as String) 
          : DateTime.now(),
      totalPrice: (json['total_price'] as num?)?.toInt() ?? 0,
      items: parsedItems,
    );
  }).toList();
});
