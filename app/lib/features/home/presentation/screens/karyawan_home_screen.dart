import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konveksio_app/features/auth/providers/auth_provider.dart';

class KaryawanHomeScreen extends ConsumerWidget {
  const KaryawanHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Karyawan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authControllerProvider.notifier).logout();
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Selamat Datang, Karyawan!'),
      ),
    );
  }
}
