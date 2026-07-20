import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/konveksio_button.dart';
import '../../../../core/widgets/konveksio_text_field.dart';

class KaryawanKasbonFormModal {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const _KaryawanKasbonFormModalContent(),
    );
  }
}

class _KaryawanKasbonFormModalContent extends StatelessWidget {
  const _KaryawanKasbonFormModalContent();

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
              const Text('Ajukan Kasbon Baru', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              IconButton(
                icon: const Icon(PhosphorIconsRegular.x),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingBase),
          const KonveksioTextField(
            label: 'Nominal Pinjaman (Rp)',
            hintText: 'Contoh: 100.000',
            keyboardType: TextInputType.number,
            prefixIcon: Icon(PhosphorIconsRegular.money),
          ),
          const SizedBox(height: AppTheme.spacingSm),
          const Text('Alasan Pengajuan', style: TextStyle(color: AppTheme.muted, fontSize: 13)),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            items: const [
              DropdownMenuItem(value: '1', child: Text('Kebutuhan Harian')),
              DropdownMenuItem(value: '2', child: Text('Sekolah Anak')),
              DropdownMenuItem(value: '3', child: Text('Listrik / Air')),
              DropdownMenuItem(value: '4', child: Text('Kesehatan / Obat')),
              DropdownMenuItem(value: '5', child: Text('Lainnya')),
            ],
            onChanged: (v) {},
            hint: const Text('Pilih alasan...'),
          ),
          const SizedBox(height: AppTheme.spacingSm),
          const Text(
            'Kasbon akan otomatis dipotong pada saat penggajian mingguan sesuai dengan limit yang ditetapkan.',
            style: TextStyle(color: AppTheme.muted, fontSize: 11),
          ),
          const SizedBox(height: AppTheme.spacingXl),
          KonveksioButton(
            text: 'Ajukan Kasbon',
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
