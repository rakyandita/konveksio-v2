// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: invalid_annotation_target

part of 'size_group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SizeGroupModel _$SizeGroupModelFromJson(Map<String, dynamic> json) =>
    _SizeGroupModel(
      id: json['id'] as String,
      branchId: json['branch_id'] as String?,
      name: json['name'] as String,
      sizes: (json['sizes'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$SizeGroupModelToJson(_SizeGroupModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'branch_id': instance.branchId,
      'name': instance.name,
      'sizes': instance.sizes,
    };
