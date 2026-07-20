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

import '../../features/dashboard/presentation/boss_shell.dart';
import '../../features/dashboard/presentation/boss_dashboard_screen.dart';
import '../../features/dashboard/presentation/boss_orders_screen.dart';
import '../../features/dashboard/presentation/boss_pipeline_screen.dart';
import '../../features/dashboard/presentation/boss_profil_screen.dart';

import '../../features/dashboard/presentation/owner_shell.dart';
import '../../features/dashboard/presentation/owner_dashboard_screen.dart';
import '../../features/dashboard/presentation/owner_cabang_screen.dart';
import '../../features/dashboard/presentation/owner_akun_screen.dart';
import '../../features/dashboard/presentation/owner_profil_screen.dart';

import '../../features/finance/presentation/karyawan_kasbon_screen.dart';
import '../../features/finance/presentation/boss_kasbon_approval_screen.dart';
import '../../features/finance/presentation/karyawan_salary_screen.dart';
import '../../features/production/presentation/spk_viewer_screen.dart';

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
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return OwnerShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/owner/home',
                builder: (context, state) => const OwnerDashboardScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/owner/cabang',
                builder: (context, state) => const OwnerCabangScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/owner/akun',
                builder: (context, state) => const OwnerAkunScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/owner/profil',
                builder: (context, state) => const OwnerProfilScreen(),
              ),
            ],
          ),
        ],
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return BossShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/boss/home',
                builder: (context, state) => const BossDashboardScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/boss/orders',
                builder: (context, state) => const BossOrdersScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/boss/pipeline',
                builder: (context, state) => const BossPipelineScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/boss/profil',
                builder: (context, state) => const BossProfilScreen(),
              ),
            ],
          ),
        ],
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
      GoRoute(
        path: '/karyawan/kasbon',
        builder: (context, state) => const KaryawanKasbonScreen(),
      ),
      GoRoute(
        path: '/karyawan/salary',
        builder: (context, state) => const KaryawanSalaryScreen(),
      ),
      GoRoute(
        path: '/karyawan/spk/:id',
        builder: (context, state) => SpkViewerScreen(
          orderItemId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: '/boss/finance/kasbon',
        builder: (context, state) => const BossKasbonApprovalScreen(),
      ),
    ],
  );
});


