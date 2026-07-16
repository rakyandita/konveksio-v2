class UserProfile {
  final String id;
  final String role;
  final String? branchId;

  UserProfile({
    required this.id,
    required this.role,
    this.branchId,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as String,
      role: json['role'] as String,
      branchId: json['branch_id'] as String?,
    );
  }
}
