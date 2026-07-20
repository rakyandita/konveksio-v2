// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: invalid_annotation_target

part of 'adjustment_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AdjustmentItemModel _$AdjustmentItemModelFromJson(Map<String, dynamic> json) =>
    _AdjustmentItemModel(
      id: json['id'] as String,
      orderId: json['order_id'] as String,
      name: json['name'] as String,
      amount: (json['amount'] as num).toDouble(),
      type: $enumDecode(_$AdjustmentTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$AdjustmentItemModelToJson(
  _AdjustmentItemModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'order_id': instance.orderId,
  'name': instance.name,
  'amount': instance.amount,
  'type': _$AdjustmentTypeEnumMap[instance.type]!,
};

const _$AdjustmentTypeEnumMap = {
  AdjustmentType.addition: 'addition',
  AdjustmentType.discount: 'discount',
};
