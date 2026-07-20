import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/konveksio_button.dart';

class MasterEmployeesDetailScreen extends StatelessWidget {
  final String employeeId;
  const MasterEmployeesDetailScreen({super.key, required this.employeeId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Detail Karyawan'),
        backgroundColor: AppTheme.surface,
        actions: [
          IconButton(
            icon: const Icon(PhosphorIconsRegular.pencilSimple),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingBase),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 40,
                backgroundColor: AppTheme.primary.withOpacity(0.1),
                child: const Icon(PhosphorIconsRegular.user, size: 40, color: AppTheme.primary),
              ),
            ),
            const SizedBox(height: AppTheme.spacingBase),
            Center(
              child: Text('Agus Supriyanto', style: Theme.of(context).textTheme.headlineSmall),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 4),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text('Divisi Jahit', style: TextStyle(color: AppTheme.primary, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: AppTheme.spacingXl),
            
            const Text('Metrik Kinerja (Bulan Ini)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: AppTheme.spacingSm),
            Row(
              children: [
                Expanded(child: _buildMetricCard('Pcs Selesai', '1,450')),
                const SizedBox(width: AppTheme.spacingSm),
                Expanded(child: _buildMetricCard('Target', '98%')),
              ],
            ),
            
            const SizedBox(height: AppTheme.spacingXl),
            const Text('Informasi Personal', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: AppTheme.spacingSm),
            _buildInfoCard(
              context,
              children: [
                _buildInfoRow('Email Akun', 'agus@konveksio.id'),
                const Divider(),
                _buildInfoRow('Nomor HP', '+62 821-9988-7766'),
                const Divider(),
                _buildInfoRow('Bergabung', '12 Jan 2022'),
              ],
            ),
            
            const SizedBox(height: AppTheme.spacingXl),
            KonveksioButton(
              text: 'Nonaktifkan Akun',
              type: KonveksioButtonType.destructive,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(color: AppTheme.border),
      ),
      child: Column(
        children: [
          Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.primary)),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(fontSize: 12, color: AppTheme.muted)),
        ],
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, {required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(color: AppTheme.border),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(label, style: const TextStyle(color: AppTheme.muted, fontSize: 13)),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
          ),
        ],
      ),
    );
  }
}
