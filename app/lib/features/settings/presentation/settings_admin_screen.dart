import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/konveksio_button.dart';
import 'forms/settings_admin_form_modal.dart' as import_modal;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../master/presentation/providers/employee_provider.dart';

class SettingsAdminScreen extends ConsumerWidget {
  const SettingsAdminScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adminsAsync = ref.watch(adminListProvider);

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Pengaturan Admin'),
        backgroundColor: AppTheme.surface,
        scrolledUnderElevation: 4.0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingBase),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Daftar Admin / Staf', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: AppTheme.spacingSm),
            adminsAsync.when(
              data: (admins) {
                if (admins.isEmpty) {
                  return const Center(child: Text('Belum ada admin'));
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: admins.length,
                  itemBuilder: (context, index) {
                    final admin = admins[index];
                    return Card(
                      elevation: 0,
                      color: AppTheme.surface,
                      margin: const EdgeInsets.only(bottom: AppTheme.spacingSm),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                        side: const BorderSide(color: AppTheme.border),
                      ),
                      child: ListTile(
                        leading: const CircleAvatar(child: Icon(PhosphorIconsRegular.userGear)),
                        title: Text(admin.name),
                        subtitle: Text('Role: ${admin.role}'),
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Error: $error')),
            ),
            const SizedBox(height: AppTheme.spacingLg),
            KonveksioButton(
              text: 'TAMBAH ADMIN BARU',
              onPressed: () {
                import_modal.SettingsAdminFormModal.show(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
