import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/domain/auth_state.dart';
import '../../features/auth/presentation/auth_controller.dart';
import '../../features/auth/presentation/login_screen.dart';

import '../../features/dashboard/presentation/karyawan_shell.dart';
import '../../features/dashboard/presentation/karyawan_beranda_screen.dart';
import '../../features/dashboard/presentation/karyawan_produksi_screen.dart';
import '../../features/dashboard/presentation/karyawan_keuangan_screen.dart';
import '../../features/dashboard/presentation/karyawan_profil_screen.dart';

import '../../features/dashboard/presentation/boss_dashboard_screen.dart';
import '../../features/dashboard/presentation/owner_dashboard_screen.dart';

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
        builder: (context, state) => const OwnerDashboardScreen(),
      ),
      GoRoute(
        path: '/boss/home',
        builder: (context, state) => const BossDashboardScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return KaryawanShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/karyawan/home',
                builder: (context, state) => const KaryawanBerandaScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/karyawan/produksi',
                builder: (context, state) => const KaryawanProduksiScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/karyawan/keuangan',
                builder: (context, state) => const KaryawanKeuanganScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/karyawan/profil',
                builder: (context, state) => const KaryawanProfilScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});


