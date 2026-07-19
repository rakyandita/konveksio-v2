import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import '../../../core/theme/app_theme.dart';
import '../../auth/presentation/auth_controller.dart';

class KaryawanProfilScreen extends ConsumerWidget {
  const KaryawanProfilScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        backgroundColor: AppTheme.surface,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundColor: AppTheme.primary,
              child: Text(
                'B',
                style: TextStyle(fontSize: 32, color: AppTheme.onPrimary, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            Text('Budi', style: Theme.of(context).textTheme.headlineMedium),
            Text('Divisi Jahit', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppTheme.muted)),
            const SizedBox(height: 32),
            ListTile(
              leading: Icon(PhosphorIconsRegular.user, color: AppTheme.foreground),
              title: const Text('Edit Profil'),
              trailing: Icon(PhosphorIconsRegular.caretRight),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              leading: Icon(PhosphorIconsRegular.signOut, color: AppTheme.destructive),
              title: const Text(
                'Keluar', style: TextStyle(color: AppTheme.destructive)),
              onTap: () {
                ref.read(authControllerProvider.notifier).logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
