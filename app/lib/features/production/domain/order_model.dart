import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_model.freezed.dart';
part 'order_model.g.dart';

@freezed
abstract class OrderModel with _$OrderModel {

        const factory OrderModel({
    required String id,
    String? branchId,
    required String orderNumber,
    required String customerId,
    DateTime? orderDate,
    DateTime? targetDate,
    required String status,
    @Default(0) double totalAmount,
    @Default(0) double downPayment,
    @Default(0) double remainingPayment,
  }) = _OrderModel;

  factory OrderModel.fromJson(Map<String, dynamic> json) => _$OrderModelFromJson(json);
}

@freezed
abstract class OrderItemModel with _$OrderItemModel {

        const factory OrderItemModel({
    required String id,
    required String orderId,
    required String productId,
    required double price,
    String? notes,
  }) = _OrderItemModel;

  factory OrderItemModel.fromJson(Map<String, dynamic> json) => _$OrderItemModelFromJson(json);
}

@freezed
abstract class OrderItemSizeModel with _$OrderItemSizeModel {

        const factory OrderItemSizeModel({
    required String id,
    required String orderItemId,
    required String size,
    required int quantity,
  }) = _OrderItemSizeModel;

  factory OrderItemSizeModel.fromJson(Map<String, dynamic> json) => _$OrderItemSizeModelFromJson(json);
}
