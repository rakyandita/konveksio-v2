import 'package:flutter/foundation.dart';

enum ApprovalStatus {
  pending,
  approved,
  rejected,
}

class CashAdvance {
  final String id;
  final String branchId;
  final String userId;
  final double amountRequested;
  final double? amountApproved;
  final String? reason;
  final ApprovalStatus status;
  final DateTime createdAt;
  final DateTime? approvedAt;
  final String? rejectionReason;

  const CashAdvance({
    required this.id,
    required this.branchId,
    required this.userId,
    required this.amountRequested,
    this.amountApproved,
    this.reason,
    required this.status,
    required this.createdAt,
    this.approvedAt,
    this.rejectionReason,
  });

  factory CashAdvance.fromJson(Map<String, dynamic> json) {
    return CashAdvance(
      id: json['id'] as String,
      branchId: json['branch_id'] as String,
      userId: json['user_id'] as String,
      amountRequested: (json['amount_requested'] as num).toDouble(),
      amountApproved: json['amount_approved'] != null ? (json['amount_approved'] as num).toDouble() : null,
      reason: json['reason'] as String?,
      status: ApprovalStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => ApprovalStatus.pending,
      ),
      createdAt: DateTime.parse(json['created_at'] as String),
      approvedAt: json['approved_at'] != null ? DateTime.parse(json['approved_at'] as String) : null,
      rejectionReason: json['rejection_reason'] as String?,
    );
  }
}
