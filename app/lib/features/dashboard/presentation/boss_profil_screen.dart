import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import '../../auth/presentation/auth_controller.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/konveksio_button.dart';

class BossProfilScreen extends ConsumerWidget {
  const BossProfilScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Profil Cabang'),
        backgroundColor: AppTheme.surface,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingBase),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundColor: AppTheme.border,
              child: Icon(PhosphorIconsRegular.storefront, size: 40, color: AppTheme.muted),
            ),
            const SizedBox(height: AppTheme.spacingBase),
            Text('Cabang Utama Jakarta', style: Theme.of(context).textTheme.titleLarge),
            Text('Admin: Budi', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.muted)),
            
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
                    leading: const Icon(PhosphorIconsRegular.storefront, color: AppTheme.primary),
                    title: const Text('Pengaturan Cabang'),
                    trailing: const Icon(Icons.chevron_right, color: AppTheme.muted),
                    onTap: () => context.push('/boss/settings/branch'),
                  ),
                  const Divider(height: 1, color: AppTheme.border),
                  ListTile(
                    leading: const Icon(PhosphorIconsRegular.userGear, color: AppTheme.primary),
                    title: const Text('Pengaturan Admin'),
                    trailing: const Icon(Icons.chevron_right, color: AppTheme.muted),
                    onTap: () => context.push('/boss/settings/admin'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.spacingXl),
            KonveksioButton(
              text: 'Kembali ke Owner Dashboard',
              type: KonveksioButtonType.secondary,
              onPressed: () {
                context.go('/owner/home');
              },
            ),
            const SizedBox(height: AppTheme.spacingBase),
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
