import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/domain/auth_state.dart';
import '../../features/auth/presentation/auth_controller.dart';
import '../../features/auth/presentation/login_screen.dart';

class RouterNotifier extends ChangeNotifier {
  final Ref _ref;
  RouterNotifier(this._ref) {
    _ref.listen<AuthState>(
      authControllerProvider,
      (previous, next) {
        // Only notify router if auth status or role changes
        if (previous?.isAuthenticated != next.isAuthenticated || previous?.role != next.role) {
          notifyListeners();
        }
      },
    );
  }
}

final routerProvider = Provider<GoRouter>((ref) {
  final notifier = RouterNotifier(ref);

  return GoRouter(
    initialLocation: '/login',
    refreshListenable: notifier,
    redirect: (context, state) {
      final authState = ref.read(authControllerProvider);
      
      // Still loading session
      if (authState.isLoading && !authState.isAuthenticated && authState.errorMessage == null) {
        // We could return a splash screen here, but we'll let it show login for now.
      }

      final isGoingToLogin = state.matchedLocation == '/login';

      if (!authState.isAuthenticated) {
        return isGoingToLogin ? null : '/login';
      }

      if (isGoingToLogin) {
        // UC-000 Redirect based on role
        switch (authState.role) {
          case UserRole.owner:
            return '/owner/home';
          case UserRole.boss:
          case UserRole.admin:
            return '/boss/home';
          case UserRole.employee:
            return '/karyawan/home';
          default:
            return null; // Unknown role
        }
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/owner/home',
        builder: (context, state) => _buildPlaceholder('Dashboard Owner', ref),
      ),
      GoRoute(
        path: '/boss/home',
        builder: (context, state) => _buildPlaceholder('Dashboard Cabang', ref),
      ),
      GoRoute(
        path: '/karyawan/home',
        builder: (context, state) => _buildPlaceholder('Dashboard Karyawan', ref),
      ),
    ],
  );
});

Widget _buildPlaceholder(String title, Ref ref) {
  return Scaffold(
    appBar: AppBar(
      title: Text(title),
      actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            ref.read(authControllerProvider.notifier).logout();
          },
        )
      ],
    ),
    body: Center(child: Text(title)),
  );
}
