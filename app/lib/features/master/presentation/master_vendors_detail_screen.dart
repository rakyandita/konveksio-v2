import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/konveksio_button.dart';

class MasterVendorsDetailScreen extends StatelessWidget {
  final String vendorId;
  const MasterVendorsDetailScreen({super.key, required this.vendorId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Detail Vendor'),
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
                child: const Icon(PhosphorIconsRegular.buildings, size: 40, color: AppTheme.primary),
              ),
            ),
            const SizedBox(height: AppTheme.spacingBase),
            Center(
              child: Text('Sablon Makmur Jaya', style: Theme.of(context).textTheme.headlineSmall),
            ),
            Center(
              child: Text('Mitra Aktif', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.success)),
            ),
            const SizedBox(height: AppTheme.spacingXl),
            
            const Text('Metrik Kinerja', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: AppTheme.spacingSm),
            Row(
              children: [
                Expanded(child: _buildMetricCard('Total Order', '124')),
                const SizedBox(width: AppTheme.spacingSm),
                Expanded(child: _buildMetricCard('On Time', '95%')),
                const SizedBox(width: AppTheme.spacingSm),
                Expanded(child: _buildMetricCard('Defect Rate', '1.2%')),
              ],
            ),
            
            const SizedBox(height: AppTheme.spacingXl),
            const Text('Informasi Detail', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: AppTheme.spacingSm),
            _buildInfoCard(
              context,
              children: [
                _buildInfoRow('Jenis Layanan', 'Sablon (Plastisol, Rubber)'),
                const Divider(),
                _buildInfoRow('PIC / Narahubung', 'Bapak Agung (+62 812-3456-7890)'),
                const Divider(),
                _buildInfoRow('Alamat', 'Jl. Sukajadi No. 42, Bandung'),
              ],
            ),
            
            const SizedBox(height: AppTheme.spacingXl),
            KonveksioButton(
              text: 'Nonaktifkan Vendor',
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
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(color: AppTheme.border),
      ),
      child: Column(
        children: [
          Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.primary)),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(fontSize: 10, color: AppTheme.muted), textAlign: TextAlign.center),
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
            width: 100,
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
