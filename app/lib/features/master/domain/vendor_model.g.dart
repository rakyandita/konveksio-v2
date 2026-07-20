// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: invalid_annotation_target

part of 'vendor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VendorModel _$VendorModelFromJson(Map<String, dynamic> json) => _VendorModel(
  id: json['id'] as String,
  branchId: json['branch_id'] as String?,
  name: json['name'] as String,
  division: json['division'] as String,
  phone: json['phone'] as String?,
  notes: json['notes'] as String?,
  isActive: json['is_active'] as bool? ?? true,
);

Map<String, dynamic> _$VendorModelToJson(_VendorModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'branch_id': instance.branchId,
      'name': instance.name,
      'division': instance.division,
      'phone': instance.phone,
      'notes': instance.notes,
      'is_active': instance.isActive,
    };
