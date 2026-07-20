import 'package:freezed_annotation/freezed_annotation.dart';

part 'employee_rate_model.freezed.dart';
part 'employee_rate_model.g.dart';

@freezed
abstract class EmployeeRateModel with _$EmployeeRateModel {

        const factory EmployeeRateModel({
    required String id,
    String? branchId,
    required String employeeId,
    required String operationType,
    required double ratePerPiece,
    @Default(true) bool isActive,
  }) = _EmployeeRateModel;

  factory EmployeeRateModel.fromJson(Map<String, dynamic> json) => _$EmployeeRateModelFromJson(json);
}
