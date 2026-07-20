// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: invalid_annotation_target

part of 'spk_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SpkModel _$SpkModelFromJson(Map<String, dynamic> json) => _SpkModel(
  id: json['id'] as String,
  branchId: json['branch_id'] as String?,
  orderId: json['order_id'] as String,
  spkNumber: json['spk_number'] as String,
  status: json['status'] as String,
);

Map<String, dynamic> _$SpkModelToJson(_SpkModel instance) => <String, dynamic>{
  'id': instance.id,
  'branch_id': instance.branchId,
  'order_id': instance.orderId,
  'spk_number': instance.spkNumber,
  'status': instance.status,
};
