import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/konveksio_button.dart';
import '../../../../core/widgets/konveksio_text_field.dart';

class MasterSizeGroupFormModal {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const _MasterSizeGroupFormModalContent(),
    );
  }
}

class _MasterSizeGroupFormModalContent extends StatelessWidget {
  const _MasterSizeGroupFormModalContent();

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
              const Text('Tambah Size Group', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              IconButton(
                icon: const Icon(PhosphorIconsRegular.x),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingBase),
          const KonveksioTextField(
            label: 'Nama Group Ukuran',
            hintText: 'Contoh: Baju Dewasa Internasional',
            prefixIcon: Icon(PhosphorIconsRegular.tag),
          ),
          const SizedBox(height: AppTheme.spacingSm),
          const KonveksioTextField(
            label: 'Daftar Ukuran (Pisahkan dengan koma)',
            hintText: 'Contoh: S,M,L,XL,XXL',
            maxLines: 2,
          ),
          const SizedBox(height: 8),
          const Text(
            'Ukuran akan otomatis dipecah menjadi kolom-kolom input yang terpisah saat order.',
            style: TextStyle(color: AppTheme.muted, fontSize: 11),
          ),
          const SizedBox(height: AppTheme.spacingXl),
          KonveksioButton(
            text: 'Simpan Size Group',
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
