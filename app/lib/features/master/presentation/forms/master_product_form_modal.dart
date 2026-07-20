import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/konveksio_button.dart';
import '../../../../core/widgets/konveksio_text_field.dart';

class MasterProductFormModal {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const _MasterProductFormModalContent(),
    );
  }
}

class _MasterProductFormModalContent extends StatelessWidget {
  const _MasterProductFormModalContent();

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
              const Text('Tambah Produk', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              IconButton(
                icon: const Icon(PhosphorIconsRegular.x),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingBase),
          const KonveksioTextField(
            label: 'Nama Produk',
            hintText: 'Contoh: Kaos Polo Wangky',
            prefixIcon: Icon(PhosphorIconsRegular.tShirt),
          ),
          const SizedBox(height: AppTheme.spacingSm),
          const Text('Kategori', style: TextStyle(color: AppTheme.muted, fontSize: 13)),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            items: const [
              DropdownMenuItem(value: 'atasan', child: Text('Atasan')),
              DropdownMenuItem(value: 'bawahan', child: Text('Bawahan')),
              DropdownMenuItem(value: 'setelan', child: Text('Setelan')),
              DropdownMenuItem(value: 'aksesoris', child: Text('Aksesoris')),
            ],
            onChanged: (v) {},
            hint: const Text('Pilih kategori...'),
          ),
          const SizedBox(height: AppTheme.spacingBase),
          Row(
            children: [
              Expanded(
                child: KonveksioTextField(
                  label: 'Estimasi Harga Min (Rp)',
                  hintText: '50.000',
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: AppTheme.spacingSm),
              Expanded(
                child: KonveksioTextField(
                  label: 'Estimasi Harga Max (Rp)',
                  hintText: '100.000',
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingSm),
          const Text('Size Group (Master Ukuran)', style: TextStyle(color: AppTheme.muted, fontSize: 13)),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            items: const [
              DropdownMenuItem(value: '1', child: Text('Standar Dewasa (S,M,L,XL)')),
              DropdownMenuItem(value: '2', child: Text('Standar Anak (XS,S,M,L)')),
              DropdownMenuItem(value: '0', child: Text('One Size / All Size')),
            ],
            onChanged: (v) {},
            hint: const Text('Pilih size group...'),
          ),
          const SizedBox(height: AppTheme.spacingXl),
          KonveksioButton(
            text: 'Simpan Produk',
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
