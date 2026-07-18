import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/auth_state.dart';
import '../data/auth_repository.dart';

final authControllerProvider = NotifierProvider<AuthController, AuthState>(() {
  return AuthController();
});

class AuthController extends Notifier<AuthState> {
  @override
  AuthState build() {
    // Initialize session check asynchronously after build
    Future.microtask(() => _init());
    return const AuthState();
  }

  Future<void> _init() async {
    state = state.copyWith(isLoading: true);
    final repository = ref.read(authRepositoryProvider);
    final sessionState = await repository.checkSession();
    if (sessionState != null) {
      state = sessionState;
    } else {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> login(String phone, String pin) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    final repository = ref.read(authRepositoryProvider);
    final result = await repository.signIn(phone, pin);
    
    if (!result.isAuthenticated) {
      // Login failed, increment attempts
      state = result.copyWith(failedAttempts: state.failedAttempts + 1);
    } else {
      // Login success, reset attempts
      state = result.copyWith(failedAttempts: 0);
    }
  }

  Future<void> logout() async {
    state = state.copyWith(isLoading: true);
    final repository = ref.read(authRepositoryProvider);
    await repository.signOut();
    state = const AuthState();
  }
}
