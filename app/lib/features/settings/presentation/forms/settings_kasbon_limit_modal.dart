import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/konveksio_button.dart';
import '../../../../core/widgets/konveksio_text_field.dart';

class SettingsKasbonLimitModal {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const _SettingsKasbonLimitModalContent(),
    );
  }
}

class _SettingsKasbonLimitModalContent extends StatelessWidget {
  const _SettingsKasbonLimitModalContent();

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
              const Text('Atur Limit Kasbon', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              IconButton(
                icon: const Icon(PhosphorIconsRegular.x),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingBase),
          const KonveksioTextField(
            label: 'Persentase Potongan Kasbon Maksimal (%)',
            hintText: 'Contoh: 50',
            keyboardType: TextInputType.number,
            prefixIcon: Icon(PhosphorIconsRegular.percent),
          ),
          const SizedBox(height: 8),
          const Text(
            'Jika diisi 50, maka karyawan yang bergaji Rp 1.000.000 dan memiliki utang Rp 800.000 hanya akan dipotong Rp 500.000 pada minggu tersebut.',
            style: TextStyle(color: AppTheme.muted, fontSize: 11),
          ),
          const SizedBox(height: AppTheme.spacingXl),
          KonveksioButton(
            text: 'Simpan Pengaturan',
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
