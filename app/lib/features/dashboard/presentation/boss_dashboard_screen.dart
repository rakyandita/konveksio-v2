import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../auth/presentation/auth_controller.dart';

class BossDashboardScreen extends ConsumerWidget {
  const BossDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Cabang'),
        backgroundColor: AppTheme.surface,
        scrolledUnderElevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authControllerProvider.notifier).logout();
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Alert Box
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.destructive.withOpacity(0.1),
                border: Border.all(color: AppTheme.destructive),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.warning_rounded, color: AppTheme.destructive),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Perhatian',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppTheme.destructive),
                        ),
                        Text(
                          'Ada 3 pengajuan kasbon yang menunggu persetujuan.',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppTheme.destructive),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text('Ringkasan Hari Ini', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            
            // Bento Grid
            Row(
              children: [
                Expanded(
                  child: _buildBentoCard(
                    context,
                    title: 'Pesanan Masuk',
                    value: '12',
                    icon: Icons.inventory_2_outlined,
                    color: AppTheme.primary,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildBentoCard(
                    context,
                    title: 'Produksi Selesai',
                    value: '450 pcs',
                    icon: Icons.check_circle_outline,
                    color: AppTheme.success,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildBentoCard(
                    context,
                    title: 'Hadir',
                    value: '18 / 20',
                    icon: Icons.people_outline,
                    color: AppTheme.secondary,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildBentoCard(
                    context,
                    title: 'Kasbon Tertunda',
                    value: 'Rp 1.5M',
                    icon: Icons.attach_money,
                    color: AppTheme.destructive,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Text('Aksi Cepat', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                _buildQuickAction(context, 'Buat SPK', Icons.note_add_outlined),
                _buildQuickAction(context, 'Terima Setoran', Icons.payments_outlined),
                _buildQuickAction(context, 'Data Karyawan', Icons.contact_page_outlined),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBentoCard(BuildContext context, {required String title, required String value, required IconData icon, required Color color}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color),
              const Icon(Icons.arrow_outward, size: 16, color: AppTheme.muted),
            ],
          ),
          const SizedBox(height: 16),
          Text(value, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 4),
          Text(title, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }

  Widget _buildQuickAction(BuildContext context, String title, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppTheme.primary, size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
