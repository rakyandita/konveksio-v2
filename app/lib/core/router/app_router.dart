import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/master_data/presentation/screens/product_catalog_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      final session = Supabase.instance.client.auth.currentSession;
      final isLoggingIn = state.matchedLocation == '/login';

      if (session == null && !isLoggingIn) {
        return '/login';
      }

      if (session != null && isLoggingIn) {
        // Asumsi jika sudah login dilempar ke root. Nanti logika redirect
        // sesuai role diatur setelah ambil data karyawan.
        return '/';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/products',
        builder: (context, state) {
          final branchId = state.uri.queryParameters['branchId'] ?? 'dummy_branch_id';
          return ProductCatalogScreen(branchId: branchId);
        },
      ),
      // Dummy home for now
      GoRoute(
        path: '/',
        builder: (context, state) => const Placeholder(), // Ganti dengan Home/Dashboard nanti
      ),
    ],
  );
});
