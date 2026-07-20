import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import '../../auth/presentation/auth_controller.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/konveksio_button.dart';

class OwnerProfilScreen extends ConsumerWidget {
  const OwnerProfilScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Profil Saya'),
        backgroundColor: AppTheme.surface,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingBase),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundColor: AppTheme.primary,
              child: Icon(PhosphorIconsRegular.userCircle, size: 40, color: AppTheme.onPrimary),
            ),
            const SizedBox(height: AppTheme.spacingBase),
            Text('Owner (Super Admin)', style: Theme.of(context).textTheme.titleLarge),
            Text('owner@konveksio.id', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.muted)),
            
            const SizedBox(height: AppTheme.spacingXl),
            Card(
              elevation: 0,
              color: AppTheme.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                side: const BorderSide(color: AppTheme.border),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(PhosphorIconsRegular.gear, color: AppTheme.primary),
                    title: const Text('Pengaturan Sistem Global'),
                    trailing: const Icon(Icons.chevron_right, color: AppTheme.muted),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Menu Pengaturan Sistem belum tersedia')));
                    },
                  ),
                  const Divider(height: 1, color: AppTheme.border),
                  ListTile(
                    leading: const Icon(PhosphorIconsRegular.shieldCheck, color: AppTheme.primary),
                    title: const Text('Keamanan & Sandi'),
                    trailing: const Icon(Icons.chevron_right, color: AppTheme.muted),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Menu Keamanan & Sandi belum tersedia')));
                    },
                  ),
                  const Divider(height: 1, color: AppTheme.border),
                  ListTile(
                    leading: const Icon(PhosphorIconsRegular.info, color: AppTheme.primary),
                    title: const Text('Tentang Konveksio'),
                    trailing: const Icon(Icons.chevron_right, color: AppTheme.muted),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Konveksio v2.0.0')));
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.spacingXl),
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
    );
  }
}
