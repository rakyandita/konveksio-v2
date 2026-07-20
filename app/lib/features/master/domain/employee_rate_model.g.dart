// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: invalid_annotation_target

part of 'employee_rate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EmployeeRateModel _$EmployeeRateModelFromJson(Map<String, dynamic> json) =>
    _EmployeeRateModel(
      id: json['id'] as String,
      branchId: json['branch_id'] as String?,
      employeeId: json['employee_id'] as String,
      operationType: json['operation_type'] as String,
      ratePerPiece: (json['rate_per_piece'] as num).toDouble(),
      isActive: json['is_active'] as bool? ?? true,
    );

Map<String, dynamic> _$EmployeeRateModelToJson(_EmployeeRateModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'branch_id': instance.branchId,
      'employee_id': instance.employeeId,
      'operation_type': instance.operationType,
      'rate_per_piece': instance.ratePerPiece,
      'is_active': instance.isActive,
    };
