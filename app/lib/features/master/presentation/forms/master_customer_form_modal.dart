import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/konveksio_button.dart';
import '../../../../core/widgets/konveksio_text_field.dart';

class MasterCustomerFormModal {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const _MasterCustomerFormModalContent(),
    );
  }
}

class _MasterCustomerFormModalContent extends StatelessWidget {
  const _MasterCustomerFormModalContent();

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return Container(
      decoration: const BoxDecoration(
        color: AppTheme.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppTheme.radiusXl)),
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
              const Text('Tambah Customer', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              IconButton(
                icon: const Icon(PhosphorIconsRegular.x),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingBase),
          const KonveksioTextField(
            label: 'Nama Lengkap / Instansi',
            hintText: 'Contoh: PT. Bintang Sejahtera',
            prefixIcon: PhosphorIconsRegular.user,
          ),
          const SizedBox(height: AppTheme.spacingSm),
          const KonveksioTextField(
            label: 'Nomor WhatsApp',
            hintText: 'Contoh: 081234567890',
            keyboardType: TextInputType.phone,
            prefixIcon: PhosphorIconsRegular.whatsappLogo,
          ),
          const SizedBox(height: AppTheme.spacingSm),
          const KonveksioTextField(
            label: 'Alamat Pengiriman',
            hintText: 'Alamat lengkap dengan kodepos',
            maxLines: 3,
            prefixIcon: PhosphorIconsRegular.mapPin,
          ),
          const SizedBox(height: AppTheme.spacingSm),
          const KonveksioTextField(
            label: 'Catatan (Opsional)',
            hintText: 'Contoh: Sering repeat order akhir tahun',
          ),
          const SizedBox(height: AppTheme.spacingXl),
          KonveksioButton(
            text: 'Simpan Customer',
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
