// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: invalid_annotation_target

part of 'salary_record_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SalaryRecordModel _$SalaryRecordModelFromJson(Map<String, dynamic> json) =>
    _SalaryRecordModel(
      id: json['id'] as String,
      branchId: json['branch_id'] as String,
      userId: json['user_id'] as String,
      periodEnd: DateTime.parse(json['period_end'] as String),
      grossSalary: (json['gross_salary'] as num).toDouble(),
      cashAdvanceDeduction: (json['cash_advance_deduction'] as num).toDouble(),
      netSalary: (json['net_salary'] as num).toDouble(),
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$SalaryRecordModelToJson(_SalaryRecordModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'branch_id': instance.branchId,
      'user_id': instance.userId,
      'period_end': instance.periodEnd.toIso8601String(),
      'gross_salary': instance.grossSalary,
      'cash_advance_deduction': instance.cashAdvanceDeduction,
      'net_salary': instance.netSalary,
      'created_at': instance.createdAt.toIso8601String(),
    };
