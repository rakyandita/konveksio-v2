import 'package:freezed_annotation/freezed_annotation.dart';

part 'salary_record_model.freezed.dart';
part 'salary_record_model.g.dart';

@freezed
abstract class SalaryRecordModel with _$SalaryRecordModel {
  const factory SalaryRecordModel({
    required String id,
    required String branchId,
    required String userId,
    required DateTime periodEnd,
    required double grossSalary,
    required double cashAdvanceDeduction,
    required double netSalary,
    required DateTime createdAt,
  }) = _SalaryRecordModel;

  factory SalaryRecordModel.fromJson(Map<String, dynamic> json) => _$SalaryRecordModelFromJson(json);
}
