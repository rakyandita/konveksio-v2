import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../auth/presentation/auth_controller.dart';
import '../../../core/widgets/konveksio_button.dart';

class BossProfilScreen extends ConsumerWidget {
  const BossProfilScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil Cabang')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Halaman Profil & Pengaturan (Placeholder)'),
              const SizedBox(height: 24),
              KonveksioButton(
                text: 'Keluar (Logout)',
                type: KonveksioButtonType.destructive,
                onPressed: () {
                  ref.read(authControllerProvider.notifier).logout();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
