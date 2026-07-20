import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/konveksio_button.dart';
import '../../../../core/widgets/konveksio_text_field.dart';

class MasterEmployeeFormModal {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const _MasterEmployeeFormModalContent(),
    );
  }
}

class _MasterEmployeeFormModalContent extends StatelessWidget {
  const _MasterEmployeeFormModalContent();

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
              const Text('Tambah Karyawan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              IconButton(
                icon: const Icon(PhosphorIconsRegular.x),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingBase),
          const KonveksioTextField(
            label: 'Nama Lengkap',
            hintText: 'Contoh: Budi Susanto',
            prefixIcon: PhosphorIconsRegular.user,
          ),
          const SizedBox(height: AppTheme.spacingSm),
          const KonveksioTextField(
            label: 'Email Akun / Username',
            hintText: 'Contoh: budi@konveksio.id',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: AppTheme.spacingSm),
          const Text('Divisi Produksi', style: TextStyle(color: AppTheme.muted, fontSize: 13)),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            items: const [
              DropdownMenuItem(value: 'potong', child: Text('Divisi Potong')),
              DropdownMenuItem(value: 'sablon', child: Text('Divisi Sablon')),
              DropdownMenuItem(value: 'jahit', child: Text('Divisi Jahit')),
              DropdownMenuItem(value: 'finishing', child: Text('Divisi Finishing')),
            ],
            onChanged: (v) {},
            hint: const Text('Pilih divisi...'),
          ),
          const SizedBox(height: AppTheme.spacingBase),
          const KonveksioTextField(
            label: 'Ongkos Borongan per Pcs (Rp)',
            hintText: 'Contoh: 2.000',
            keyboardType: TextInputType.number,
            prefixIcon: PhosphorIconsRegular.money,
          ),
          const SizedBox(height: AppTheme.spacingXl),
          KonveksioButton(
            text: 'Simpan Karyawan',
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
