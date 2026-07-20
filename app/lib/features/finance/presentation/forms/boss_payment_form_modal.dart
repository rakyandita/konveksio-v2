import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/konveksio_button.dart';
import '../../../../core/widgets/konveksio_text_field.dart';

class BossPaymentFormModal {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const _BossPaymentFormModalContent(),
    );
  }
}

class _BossPaymentFormModalContent extends StatelessWidget {
  const _BossPaymentFormModalContent();

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
              const Text('Input Pembayaran', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              IconButton(
                icon: const Icon(PhosphorIconsRegular.x),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingBase),
          const Text('Kategori Pembayaran', style: TextStyle(color: AppTheme.muted, fontSize: 13)),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            items: const [
              DropdownMenuItem(value: 'dp', child: Text('Uang Muka (DP)')),
              DropdownMenuItem(value: 'termin', child: Text('Cicilan / Termin')),
              DropdownMenuItem(value: 'lunas', child: Text('Pelunasan')),
            ],
            onChanged: (v) {},
            hint: const Text('Pilih kategori...'),
          ),
          const SizedBox(height: AppTheme.spacingBase),
          const KonveksioTextField(
            label: 'Nominal Pembayaran (Rp)',
            hintText: 'Contoh: 500.000',
            keyboardType: TextInputType.number,
            prefixIcon: Icon(PhosphorIconsRegular.money),
          ),
          const SizedBox(height: AppTheme.spacingSm),
          const KonveksioTextField(
            label: 'Tanggal Transfer / Bayar',
            hintText: 'dd-mm-yyyy',
            prefixIcon: Icon(PhosphorIconsRegular.calendar),
          ),
          const SizedBox(height: AppTheme.spacingXl),
          KonveksioButton(
            text: 'Simpan Pembayaran',
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
