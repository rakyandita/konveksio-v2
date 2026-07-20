import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/konveksio_button.dart';

class BossSalaryScreen extends StatelessWidget {
  const BossSalaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Generate Gaji Mingguan'),
        backgroundColor: AppTheme.surface,
        scrolledUnderElevation: 4.0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingBase),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingBase),
              decoration: BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                border: Border.all(color: AppTheme.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Periode Penggajian',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: AppTheme.spacingSm),
                  Text(
                    '10 Juli - 16 Juli 2026',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.spacingBase),
            const Text(
              'Pratinjau Gaji Karyawan',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppTheme.spacingSm),
            _buildSalaryCard(context, 'Budi Santoso', 'Jahit', 500000, 150000, 650000),
            _buildSalaryCard(context, 'Siti Aminah', 'Finishing', 300000, 0, 300000),
            const SizedBox(height: AppTheme.spacingLg),
            KonveksioButton(
              text: 'GENERATE SLIP GAJI & SIMPAN',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Slip gaji berhasil dibuat untuk periode ini')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSalaryCard(BuildContext context, String name, String div, int pokok, int potongan, int total) {
    return Card(
      elevation: 0,
      color: AppTheme.surface,
      margin: const EdgeInsets.only(bottom: AppTheme.spacingSm),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        side: const BorderSide(color: AppTheme.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingBase),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Chip(
                  label: Text(div, style: const TextStyle(fontSize: 10)),
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
            const Divider(color: AppTheme.border),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Upah Borongan:', style: TextStyle(color: AppTheme.muted)),
                Text('Rp $pokok'),
              ],
            ),
            if (potongan > 0)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Potongan Kasbon:', style: TextStyle(color: AppTheme.destructive)),
                  Text('- Rp $potongan', style: const TextStyle(color: AppTheme.destructive)),
                ],
              ),
            const SizedBox(height: AppTheme.spacingSm),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total Terima:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  'Rp $total',
                  style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primary, fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
