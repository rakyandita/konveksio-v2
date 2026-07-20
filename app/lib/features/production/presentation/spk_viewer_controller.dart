import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Spk {
  final String id;
  final String orderItemId;
  final String? clientName;
  final String? material;
  final String? color;
  final String? style;
  final String? frontImageUrl;
  final String? backImageUrl;
  
  // order details
  final String? orderName;
  final String? productName;

  Spk({
    required this.id,
    required this.orderItemId,
    this.clientName,
    this.material,
    this.color,
    this.style,
    this.frontImageUrl,
    this.backImageUrl,
    this.orderName,
    this.productName,
  });

  factory Spk.fromJson(Map<String, dynamic> json) {
    return Spk(
      id: json['id'] as String,
      orderItemId: json['order_item_id'] as String,
      clientName: json['client_name'] as String?,
      material: json['material'] as String?,
      color: json['color'] as String?,
      style: json['style'] as String?,
      frontImageUrl: json['front_image_url'] as String?,
      backImageUrl: json['back_image_url'] as String?,
      orderName: json['order_items']?['orders']?['customer_name'] ?? json['order_items']?['product']?['name'] ?? 'Pesanan',
      productName: json['order_items']?['products']?['name'],
    );
  }
}

final spkViewerControllerProvider =
    FutureProvider.autoDispose.family<Spk?, String>((ref, orderItemId) async {
  final supabase = Supabase.instance.client;
  
  if (supabase.auth.currentUser == null) {
    // Mock data if not logged in
    await Future.delayed(const Duration(milliseconds: 500));
    return Spk(
      id: 'spk-123',
      orderItemId: orderItemId,
      clientName: 'PT. Maju Mundur',
      material: 'Katun Combed 30s',
      color: 'Biru Navy',
      style: 'Reguler Fit, Lengan Pendek',
      frontImageUrl: null,
      backImageUrl: null,
      orderName: 'Pesanan Mock',
      productName: 'Kaus',
    );
  }

  // Fetch from spks and join with order_items -> products, and order_items -> orders
  final response = await supabase
      .from('spks')
      .select('''
        *,
        order_items (
          id,
          products (name),
          orders (id)
        )
      ''')
      .eq('order_item_id', orderItemId)
      .maybeSingle();

  if (response == null) {
    return null;
  }

  return Spk.fromJson(response);
});
