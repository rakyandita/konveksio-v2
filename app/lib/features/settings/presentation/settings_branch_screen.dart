import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/konveksio_button.dart';

class SettingsBranchScreen extends StatelessWidget {
  const SettingsBranchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Pengaturan Cabang'),
        backgroundColor: AppTheme.surface,
        scrolledUnderElevation: 4.0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingBase),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Pengaturan Profil Cabang', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: AppTheme.spacingSm),
            TextFormField(
              initialValue: 'Cabang Utama Jakarta',
              decoration: const InputDecoration(labelText: 'Nama Cabang'),
            ),
            const SizedBox(height: AppTheme.spacingBase),
            TextFormField(
              initialValue: 'Jl. Merdeka No 123, Jakarta Selatan',
              decoration: const InputDecoration(labelText: 'Alamat Cabang'),
              maxLines: 2,
            ),
            const Text('Kontak & Pembayaran (Untuk Invoice)', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: AppTheme.spacingSm),
            TextFormField(
              initialValue: '081234567890',
              decoration: const InputDecoration(
                labelText: 'Nomor WhatsApp Cabang',
                prefixIcon: Icon(PhosphorIconsRegular.whatsappLogo),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: AppTheme.spacingBase),
            TextFormField(
              initialValue: 'BCA 123456789 a/n Budi Konveksi',
              decoration: const InputDecoration(
                labelText: 'Informasi Rekening Bank',
                prefixIcon: Icon(PhosphorIconsRegular.bank),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: AppTheme.spacingLg),
            const Text('Limit Keuangan', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: AppTheme.spacingSm),
            TextFormField(
              initialValue: '500.000',
              decoration: const InputDecoration(
                labelText: 'Maksimal Kasbon per Karyawan (Rp)',
                prefixText: 'Rp ',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: AppTheme.spacingLg),
            KonveksioButton(
              text: 'SIMPAN PENGATURAN',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Pengaturan berhasil disimpan')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
