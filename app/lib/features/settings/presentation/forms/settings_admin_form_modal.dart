import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/konveksio_button.dart';
import '../../../../core/widgets/konveksio_text_field.dart';

class SettingsAdminFormModal {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const _SettingsAdminFormModalContent(),
    );
  }
}

class _SettingsAdminFormModalContent extends StatefulWidget {
  const _SettingsAdminFormModalContent();

  @override
  State<_SettingsAdminFormModalContent> createState() => _SettingsAdminFormModalContentState();
}

class _SettingsAdminFormModalContentState extends State<_SettingsAdminFormModalContent> {
  bool _canCreateOrder = true;
  bool _canManageMaster = false;
  bool _canAssignTask = true;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return Container(
      decoration: const BoxDecoration(
        color: AppTheme.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppTheme.radiusLg)),
      ),
      padding: EdgeInsets.only(
        left: AppTheme.spacingBase,
        right: AppTheme.spacingBase,
        top: AppTheme.spacingBase,
        bottom: bottomInset + AppTheme.spacingBase,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Tambah / Edit Admin', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              IconButton(
                icon: const Icon(PhosphorIconsRegular.x),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingBase),
          const KonveksioTextField(
            label: 'Nama Admin',
            hintText: 'Contoh: Rina',
            prefixIcon: Icon(PhosphorIconsRegular.user),
          ),
          const SizedBox(height: AppTheme.spacingSm),
          const KonveksioTextField(
            label: 'Email Akun',
            hintText: 'Contoh: rina@konveksio.id',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: AppTheme.spacingLg),
          const Text('Hak Akses Dinamis', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: AppTheme.spacingSm),
          CheckboxListTile(
            title: const Text('Boleh Buat Order & SPK', style: TextStyle(fontSize: 14)),
            value: _canCreateOrder,
            onChanged: (val) => setState(() => _canCreateOrder = val ?? false),
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: AppTheme.primary,
          ),
          CheckboxListTile(
            title: const Text('Boleh Kelola Master Data', style: TextStyle(fontSize: 14)),
            value: _canManageMaster,
            onChanged: (val) => setState(() => _canManageMaster = val ?? false),
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: AppTheme.primary,
          ),
          CheckboxListTile(
            title: const Text('Boleh Assign Tugas Produksi', style: TextStyle(fontSize: 14)),
            value: _canAssignTask,
            onChanged: (val) => setState(() => _canAssignTask = val ?? false),
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: AppTheme.primary,
          ),
          const SizedBox(height: AppTheme.spacingXl),
          KonveksioButton(
            text: 'Simpan Admin',
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
