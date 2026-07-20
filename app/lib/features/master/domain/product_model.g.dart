// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: invalid_annotation_target

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProductModel _$ProductModelFromJson(Map<String, dynamic> json) =>
    _ProductModel(
      id: json['id'] as String,
      branchId: json['branch_id'] as String?,
      name: json['name'] as String,
      category: json['category'] as String,
      sizeGroupId: json['size_group_id'] as String,
      priceMin: (json['price_min'] as num).toDouble(),
      priceMax: (json['price_max'] as num).toDouble(),
      isActive: json['is_active'] as bool? ?? true,
    );

Map<String, dynamic> _$ProductModelToJson(_ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'branch_id': instance.branchId,
      'name': instance.name,
      'category': instance.category,
      'size_group_id': instance.sizeGroupId,
      'price_min': instance.priceMin,
      'price_max': instance.priceMax,
      'is_active': instance.isActive,
    };
