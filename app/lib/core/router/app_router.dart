import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/auth/providers/auth_provider.dart';
import '../../features/home/presentation/screens/boss_home_screen.dart';
import '../../features/home/presentation/screens/karyawan_home_screen.dart';
import '../../features/home/presentation/screens/owner_home_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);
  final userProfile = ref.watch(userProfileProvider);

  return GoRouter(
    initialLocation: '/',
    refreshListenable: _GoRouterRefreshStream(
      // We don't directly listen to authStateProvider stream here because Riverpod
      // handles rebuilding the router when authState or userProfile changes.
      // This is a minimal implementation relying on Riverpod's reactivity.
      const Stream.empty(), 
    ),
    redirect: (context, state) {
      // 1. Wait for Auth State to load
      if (authState.isLoading) {
        return '/'; // Splash
      }

      final session = authState.value?.session;
      final isAuth = session != null;
      final isLoggingIn = state.matchedLocation == '/login';

      // 2. Not authenticated -> Redirect to Login
      if (!isAuth) {
        return isLoggingIn ? null : '/login';
      }

      // 3. Authenticated but Profile is loading
      if (userProfile.isLoading) {
        return '/'; // Splash
      }

      // 4. Authenticated, Profile loaded, but no valid role?
      final profile = userProfile.value;
      if (profile == null) {
        // Handle no profile edge case (e.g., admin hasn't configured role)
        // For now, redirect to a safe screen or show an error
        // As per sys_uc_000.md PGRST116 (0 rows) -> Toast "Profil Anda belum dikonfigurasi admin"
        // Let's redirect them back to login and force logout
        if (state.matchedLocation != '/login') {
          // You could trigger logout here or handle it at UI level.
          return '/login'; 
        }
        return null;
      }

      // 5. Authenticated and Profile loaded -> Route based on Role
      if (isLoggingIn || state.matchedLocation == '/') {
        switch (profile.role) {
          case 'owner':
            return '/owner/home';
          case 'boss':
          case 'admin':
            return '/boss/home';
          case 'employee':
            return '/karyawan/home';
          default:
            return '/login';
        }
      }

      // Default: no redirect
      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/owner/home',
        builder: (context, state) => const OwnerHomeScreen(),
      ),
      GoRoute(
        path: '/boss/home',
        builder: (context, state) => const BossHomeScreen(),
      ),
      GoRoute(
        path: '/karyawan/home',
        builder: (context, state) => const KaryawanHomeScreen(),
      ),
    ],
  );
});

class _GoRouterRefreshStream extends ChangeNotifier {
  _GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
