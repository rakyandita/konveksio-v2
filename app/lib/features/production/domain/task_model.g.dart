// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: invalid_annotation_target

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TaskModel _$TaskModelFromJson(Map<String, dynamic> json) => _TaskModel(
  id: json['id'] as String,
  orderItemId: json['order_item_id'] as String,
  assignedToUser: json['assigned_to_user'] as String?,
  assignedToVendor: json['assigned_to_vendor'] as String?,
  division: json['division'] as String,
  status: json['status'] as String,
  ongkosPerPcsSnapshot:
      (json['ongkos_per_pcs_snapshot'] as num?)?.toDouble() ?? 0,
);

Map<String, dynamic> _$TaskModelToJson(_TaskModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order_item_id': instance.orderItemId,
      'assigned_to_user': instance.assignedToUser,
      'assigned_to_vendor': instance.assignedToVendor,
      'division': instance.division,
      'status': instance.status,
      'ongkos_per_pcs_snapshot': instance.ongkosPerPcsSnapshot,
    };

_TaskSizeModel _$TaskSizeModelFromJson(Map<String, dynamic> json) =>
    _TaskSizeModel(
      id: json['id'] as String,
      taskId: json['task_id'] as String,
      size: json['size'] as String,
      targetQty: (json['target_qty'] as num).toInt(),
      completedQty: (json['completed_qty'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$TaskSizeModelToJson(_TaskSizeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'task_id': instance.taskId,
      'size': instance.size,
      'target_qty': instance.targetQty,
      'completed_qty': instance.completedQty,
    };
