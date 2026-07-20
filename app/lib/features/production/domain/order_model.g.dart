// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: invalid_annotation_target

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => _OrderModel(
  id: json['id'] as String,
  branchId: json['branch_id'] as String?,
  orderNumber: json['order_number'] as String,
  customerId: json['customer_id'] as String,
  orderDate: json['order_date'] == null
      ? null
      : DateTime.parse(json['order_date'] as String),
  targetDate: json['target_date'] == null
      ? null
      : DateTime.parse(json['target_date'] as String),
  status: json['status'] as String,
  totalAmount: (json['total_amount'] as num?)?.toDouble() ?? 0,
  downPayment: (json['down_payment'] as num?)?.toDouble() ?? 0,
  remainingPayment: (json['remaining_payment'] as num?)?.toDouble() ?? 0,
);

Map<String, dynamic> _$OrderModelToJson(_OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'branch_id': instance.branchId,
      'order_number': instance.orderNumber,
      'customer_id': instance.customerId,
      'order_date': instance.orderDate?.toIso8601String(),
      'target_date': instance.targetDate?.toIso8601String(),
      'status': instance.status,
      'total_amount': instance.totalAmount,
      'down_payment': instance.downPayment,
      'remaining_payment': instance.remainingPayment,
    };

_OrderItemModel _$OrderItemModelFromJson(Map<String, dynamic> json) =>
    _OrderItemModel(
      id: json['id'] as String,
      orderId: json['order_id'] as String,
      productId: json['product_id'] as String,
      price: (json['price'] as num).toDouble(),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$OrderItemModelToJson(_OrderItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order_id': instance.orderId,
      'product_id': instance.productId,
      'price': instance.price,
      'notes': instance.notes,
    };

_OrderItemSizeModel _$OrderItemSizeModelFromJson(Map<String, dynamic> json) =>
    _OrderItemSizeModel(
      id: json['id'] as String,
      orderItemId: json['order_item_id'] as String,
      size: json['size'] as String,
      quantity: (json['quantity'] as num).toInt(),
    );

Map<String, dynamic> _$OrderItemSizeModelToJson(_OrderItemSizeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order_item_id': instance.orderItemId,
      'size': instance.size,
      'quantity': instance.quantity,
    };
