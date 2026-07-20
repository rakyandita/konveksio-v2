// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: invalid_annotation_target

part of 'handover_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HandoverModel _$HandoverModelFromJson(Map<String, dynamic> json) =>
    _HandoverModel(
      id: json['id'] as String,
      fromTaskId: json['from_task_id'] as String,
      toUserId: json['to_user_id'] as String?,
      toVendorId: json['to_vendor_id'] as String?,
      status: json['status'] as String,
      rejectionReason: json['rejection_reason'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$HandoverModelToJson(_HandoverModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'from_task_id': instance.fromTaskId,
      'to_user_id': instance.toUserId,
      'to_vendor_id': instance.toVendorId,
      'status': instance.status,
      'rejection_reason': instance.rejectionReason,
      'created_at': instance.createdAt?.toIso8601String(),
    };

_HandoverSizeModel _$HandoverSizeModelFromJson(Map<String, dynamic> json) =>
    _HandoverSizeModel(
      id: json['id'] as String,
      handoverId: json['handover_id'] as String,
      size: json['size'] as String,
      qtySent: (json['qty_sent'] as num).toInt(),
      qtyReceived: (json['qty_received'] as num?)?.toInt(),
    );

Map<String, dynamic> _$HandoverSizeModelToJson(_HandoverSizeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'handover_id': instance.handoverId,
      'size': instance.size,
      'qty_sent': instance.qtySent,
      'qty_received': instance.qtyReceived,
    };
