// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: invalid_annotation_target

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
  id: json['id'] as String,
  branchId: json['branch_id'] as String?,
  role: json['role'] as String,
  name: json['name'] as String,
  isActive: json['is_active'] as bool? ?? true,
);

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'branch_id': instance.branchId,
      'role': instance.role,
      'name': instance.name,
      'is_active': instance.isActive,
    };
