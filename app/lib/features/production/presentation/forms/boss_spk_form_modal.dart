import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/konveksio_button.dart';
import '../../../../core/widgets/konveksio_text_field.dart';

class BossSpkFormModal {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const _BossSpkFormModalContent(),
    );
  }
}

class _BossSpkFormModalContent extends StatelessWidget {
  const _BossSpkFormModalContent();

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
              const Text('Buat/Edit SPK Digital', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              IconButton(
                icon: const Icon(PhosphorIconsRegular.x),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingBase),
          const KonveksioTextField(
            label: 'Bahan',
            hintText: 'Contoh: Cotton Combed 30s',
          ),
          const SizedBox(height: AppTheme.spacingSm),
          const KonveksioTextField(
            label: 'Warna',
            hintText: 'Contoh: Navy Blue',
          ),
          const SizedBox(height: AppTheme.spacingSm),
          const KonveksioTextField(
            label: 'Model / Style',
            hintText: 'Contoh: Lengan Pendek, Krah V-Neck',
          ),
          const SizedBox(height: AppTheme.spacingLg),
          const Text('Gambar Desain (Max 1MB)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: AppTheme.spacingSm),
          Row(
            children: [
              Expanded(
                child: _buildImageUploadMock(context, 'Tampak Depan'),
              ),
              const SizedBox(width: AppTheme.spacingSm),
              Expanded(
                child: _buildImageUploadMock(context, 'Tampak Belakang'),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingXl),
          KonveksioButton(
            text: 'Simpan SPK',
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildImageUploadMock(BuildContext context, String label) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(color: AppTheme.border, style: BorderStyle.solid),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(PhosphorIconsRegular.uploadSimple, color: AppTheme.muted),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 12, color: AppTheme.muted)),
        ],
      ),
    );
  }
}
