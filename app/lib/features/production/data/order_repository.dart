import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/supabase/supabase_client_provider.dart';
import '../domain/order_model.dart';
import '../domain/spk_model.dart';

final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  return OrderRepository(ref.watch(supabaseClientProvider));
});

class OrderRepository {
  final SupabaseClient _supabase;

  OrderRepository(this._supabase);

  Future<List<OrderModel>> getOrders() async {
    final response = await _supabase
        .from('orders')
        .select()
        .order('order_date', ascending: false);
    return response.map((json) => OrderModel.fromJson(json)).toList();
  }

  Future<String> createOrderTransaction(Map<String, dynamic> payload) async {
    final response = await _supabase.rpc('create_order_transaction', params: {'payload': payload});
    return response['order_id'] as String;
  }

  Future<OrderModel> getOrderDetail(String orderId) async {
    final response = await _supabase
        .from('orders')
        .select()
        .eq('id', orderId)
        .single();
    return OrderModel.fromJson(response);
  }

  Future<List<OrderItemModel>> getOrderItems(String orderId) async {
    final response = await _supabase
        .from('order_items')
        .select()
        .eq('order_id', orderId);
    return response.map((json) => OrderItemModel.fromJson(json)).toList();
  }

  Future<List<OrderItemSizeModel>> getOrderItemSizes(String orderItemId) async {
    final response = await _supabase
        .from('order_item_sizes')
        .select()
        .eq('order_item_id', orderItemId);
    return response.map((json) => OrderItemSizeModel.fromJson(json)).toList();
  }

  Future<SpkModel?> getSpkByOrderItem(String orderItemId) async {
    try {
      final response = await _supabase
          .from('spks')
          .select()
          .eq('order_item_id', orderItemId)
          .single();
      return SpkModel.fromJson(response);
    } catch (e) {
      return null; // Might not exist if not filled yet
    }
  }

  Future<void> updateSpk(String orderItemId, Map<String, dynamic> payload) async {
    await _supabase
        .from('spks')
        .update(payload)
        .eq('order_item_id', orderItemId);
  }
}
