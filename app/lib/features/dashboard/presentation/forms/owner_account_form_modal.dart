import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/konveksio_button.dart';
import '../../../../core/widgets/konveksio_text_field.dart';

class OwnerAccountFormModal {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const _OwnerAccountFormModalContent(),
    );
  }
}

class _OwnerAccountFormModalContent extends StatelessWidget {
  const _OwnerAccountFormModalContent();

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
              const Text('Form Akun Pengguna', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              IconButton(
                icon: const Icon(PhosphorIconsRegular.x),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingBase),
          const KonveksioTextField(
            label: 'Nama Lengkap',
            hintText: 'Contoh: Joko Anwar',
            prefixIcon: Icon(PhosphorIconsRegular.user),
          ),
          const SizedBox(height: AppTheme.spacingSm),
          const KonveksioTextField(
            label: 'Email',
            hintText: 'Contoh: joko@konveksio.id',
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Icon(PhosphorIconsRegular.envelope),
          ),
          const SizedBox(height: AppTheme.spacingSm),
          const KonveksioTextField(
            label: 'Kata Sandi',
            hintText: 'Masukkan kata sandi baru',
            obscureText: true,
            prefixIcon: Icon(PhosphorIconsRegular.lock),
          ),
          const SizedBox(height: AppTheme.spacingSm),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'Peran (Role)',
              prefixIcon: Icon(PhosphorIconsRegular.identificationCard),
            ),
            items: const [
              DropdownMenuItem(value: 'boss', child: Text('Boss Cabang')),
              DropdownMenuItem(value: 'admin', child: Text('Admin')),
            ],
            onChanged: (value) {},
          ),
          const SizedBox(height: AppTheme.spacingXl),
          KonveksioButton(
            text: 'Simpan Akun',
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
