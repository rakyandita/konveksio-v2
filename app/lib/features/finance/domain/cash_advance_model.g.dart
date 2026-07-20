// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: invalid_annotation_target

part of 'cash_advance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CashAdvanceModel _$CashAdvanceModelFromJson(Map<String, dynamic> json) =>
    _CashAdvanceModel(
      id: json['id'] as String,
      branchId: json['branch_id'] as String,
      userId: json['user_id'] as String,
      amountRequested: (json['amount_requested'] as num).toDouble(),
      amountApproved: (json['amount_approved'] as num?)?.toDouble(),
      reason: json['reason'] as String?,
      status: $enumDecode(_$ApprovalStatusEnumMap, json['status']),
      createdAt: DateTime.parse(json['created_at'] as String),
      approvedAt: json['approved_at'] == null
          ? null
          : DateTime.parse(json['approved_at'] as String),
      rejectionReason: json['rejection_reason'] as String?,
    );

Map<String, dynamic> _$CashAdvanceModelToJson(_CashAdvanceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'branch_id': instance.branchId,
      'user_id': instance.userId,
      'amount_requested': instance.amountRequested,
      'amount_approved': instance.amountApproved,
      'reason': instance.reason,
      'status': _$ApprovalStatusEnumMap[instance.status]!,
      'created_at': instance.createdAt.toIso8601String(),
      'approved_at': instance.approvedAt?.toIso8601String(),
      'rejection_reason': instance.rejectionReason,
    };

const _$ApprovalStatusEnumMap = {
  ApprovalStatus.pending: 'pending',
  ApprovalStatus.approved: 'approved',
  ApprovalStatus.rejected: 'rejected',
};
