// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: invalid_annotation_target

part of 'branch_setting_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BranchSettingModel _$BranchSettingModelFromJson(Map<String, dynamic> json) =>
    _BranchSettingModel(
      branchId: json['branch_id'] as String,
      paymentSystem: json['payment_system'] as String?,
      maxKasbonPercentage: (json['max_kasbon_percentage'] as num?)?.toInt(),
      contactWa: json['contact_wa'] as String?,
      bankAccountInfo: json['bank_account_info'] as String?,
    );

Map<String, dynamic> _$BranchSettingModelToJson(_BranchSettingModel instance) =>
    <String, dynamic>{
      'branch_id': instance.branchId,
      'payment_system': instance.paymentSystem,
      'max_kasbon_percentage': instance.maxKasbonPercentage,
      'contact_wa': instance.contactWa,
      'bank_account_info': instance.bankAccountInfo,
    };
