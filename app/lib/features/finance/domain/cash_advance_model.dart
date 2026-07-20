import 'package:freezed_annotation/freezed_annotation.dart';

part 'cash_advance_model.freezed.dart';
part 'cash_advance_model.g.dart';

enum ApprovalStatus {
  pending,
  approved,
  rejected,
}

@freezed
abstract class CashAdvanceModel with _$CashAdvanceModel {
  const factory CashAdvanceModel({
    required String id,
    required String branchId,
    required String userId,
    required double amountRequested,
    double? amountApproved,
    String? reason,
    required ApprovalStatus status,
    required DateTime createdAt,
    DateTime? approvedAt,
    String? rejectionReason,
  }) = _CashAdvanceModel;

  factory CashAdvanceModel.fromJson(Map<String, dynamic> json) => _$CashAdvanceModelFromJson(json);
}
