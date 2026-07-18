enum UserRole {
  owner,
  boss,
  admin,
  employee,
  unknown,
}

class AuthState {
  final bool isLoading;
  final String? errorMessage;
  final UserRole role;
  final String? branchId;
  final bool isAuthenticated;
  final int failedAttempts;

  const AuthState({
    this.isLoading = false,
    this.errorMessage,
    this.role = UserRole.unknown,
    this.branchId,
    this.isAuthenticated = false,
    this.failedAttempts = 0,
  });

  AuthState copyWith({
    bool? isLoading,
    String? errorMessage,
    UserRole? role,
    String? branchId,
    bool? isAuthenticated,
    int? failedAttempts,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage, // We want to be able to clear it with null
      role: role ?? this.role,
      branchId: branchId ?? this.branchId,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      failedAttempts: failedAttempts ?? this.failedAttempts,
    );
  }
}
