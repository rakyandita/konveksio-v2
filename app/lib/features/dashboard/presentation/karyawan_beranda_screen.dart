import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/konveksio_card.dart';

class KaryawanBerandaScreen extends StatelessWidget {
  const KaryawanBerandaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beranda'),
        backgroundColor: AppTheme.surface,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Halo, Budi!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 4),
            Text(
              'Divisi Jahit',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.muted),
            ),
            const SizedBox(height: 24),
            KonveksioCard(
              backgroundColor: AppTheme.primary,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Semangat Pagi!',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppTheme.onPrimary),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Hari ini ada 2 pekerjaan baru yang menunggu diterima.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.onPrimary),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _buildMetricCard(
                    context,
                    title: 'Pcs Selesai',
                    value: '120',
                    subtitle: 'Minggu ini',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildMetricCard(
                    context,
                    title: 'Proyeksi Upah',
                    value: AppFormatters.formatCurrency(350000),
                    subtitle: 'Minggu ini',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(BuildContext context, {required String title, required String value, required String subtitle}) {
    return KonveksioCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppTheme.primary),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
