// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: invalid_annotation_target

part of 'customer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CustomerModel _$CustomerModelFromJson(Map<String, dynamic> json) =>
    _CustomerModel(
      id: json['id'] as String,
      branchId: json['branch_id'] as String?,
      name: json['name'] as String,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      isActive: json['is_active'] as bool? ?? true,
    );

Map<String, dynamic> _$CustomerModelToJson(_CustomerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'branch_id': instance.branchId,
      'name': instance.name,
      'phone': instance.phone,
      'address': instance.address,
      'is_active': instance.isActive,
    };
