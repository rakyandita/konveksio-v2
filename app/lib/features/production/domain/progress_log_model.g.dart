// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: invalid_annotation_target

part of 'progress_log_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProgressLogModel _$ProgressLogModelFromJson(Map<String, dynamic> json) =>
    _ProgressLogModel(
      id: json['id'] as String,
      taskId: json['task_id'] as String,
      userId: json['user_id'] as String,
      size: json['size'] as String,
      qtyCompleted: (json['qty_completed'] as num).toInt(),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$ProgressLogModelToJson(_ProgressLogModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'task_id': instance.taskId,
      'user_id': instance.userId,
      'size': instance.size,
      'qty_completed': instance.qtyCompleted,
      'created_at': instance.createdAt?.toIso8601String(),
    };
