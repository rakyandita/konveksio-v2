import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/konveksio_button.dart';

class SettingsAdminScreen extends StatelessWidget {
  const SettingsAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            Card(
              elevation: 0,
              color: AppTheme.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                side: const BorderSide(color: AppTheme.border),
              ),
              child: const ListTile(
                leading: CircleAvatar(child: Icon(PhosphorIconsRegular.userGear)),
                title: Text('Admin Utama'),
                subtitle: Text('Akses: Semua Modul'),
              ),
            ),
            const SizedBox(height: AppTheme.spacingLg),
            KonveksioButton(
              text: 'TAMBAH ADMIN BARU',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
