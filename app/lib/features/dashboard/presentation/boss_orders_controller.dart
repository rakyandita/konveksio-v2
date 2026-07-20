import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
    // Fase 6 Mock Bypass
    await Future.delayed(const Duration(milliseconds: 600));
    return [
      Order.mock(
        id: 'ORD-001',
        customerName: 'Dinas Pendidikan',
        status: 'draft',
        deadlineDate: DateTime.now().add(const Duration(days: 14)),
        totalPrice: 7500000,
      ),
      Order.mock(
        id: 'ORD-002',
        customerName: 'Universitas Brawijaya',
        status: 'confirmation',
        deadlineDate: DateTime.now().add(const Duration(days: 7)),
        totalPrice: 15000000,
      ),
      Order.mock(
        id: 'ORD-003',
        customerName: 'PT. Maju Mundur',
        status: 'running',
        deadlineDate: DateTime.now().add(const Duration(days: 3)),
        totalPrice: 5000000,
      ),
      Order.mock(
        id: 'ORD-004',
        customerName: 'Komunitas Motor',
        status: 'completed',
        deadlineDate: DateTime.now().subtract(const Duration(days: 2)),
        totalPrice: 2000000,
      ),
    ];
  }

  // Real Database Query (Fase 7)
  // TODO: implement real Supabase query with order_items join
  return [];
});
