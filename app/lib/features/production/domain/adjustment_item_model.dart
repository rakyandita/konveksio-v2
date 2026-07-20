import 'package:freezed_annotation/freezed_annotation.dart';

part 'adjustment_item_model.freezed.dart';
part 'adjustment_item_model.g.dart';

enum AdjustmentType {
  addition,
  discount,
}

@freezed
abstract class AdjustmentItemModel with _$AdjustmentItemModel {
  const factory AdjustmentItemModel({
    required String id,
    required String orderId,
    required String name,
    required double amount,
    required AdjustmentType type,
  }) = _AdjustmentItemModel;

  factory AdjustmentItemModel.fromJson(Map<String, dynamic> json) => _$AdjustmentItemModelFromJson(json);
}
