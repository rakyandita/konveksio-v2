import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/konveksio_card.dart';

class OwnerDashboardScreen extends ConsumerWidget {
  const OwnerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('Dashboard Owner'),
            backgroundColor: AppTheme.background,
            surfaceTintColor: Colors.transparent,
            shadowColor: Color(0x26000000), // 15% black for visibility
            pinned: true,
            elevation: 0,
            scrolledUnderElevation: 4.0,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
            // Global Metrics
            Text('Metrik Global (Bulan Ini)', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildMetricCard(
                    context,
                    title: 'Total Revenue',
                    value: AppFormatters.formatCurrency(125000000),
                    icon: PhosphorIconsRegular.money,
                    color: AppTheme.primary,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildMetricCard(
                    context,
                    title: 'Total Produksi',
                    value: '15.4K',
                    icon: PhosphorIconsRegular.package,
                    color: AppTheme.secondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            
            Text('Performa Cabang', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            
            // Branch Cards
            _buildBranchCard(
              context,
              name: 'Cabang Jakarta (Pusat)',
              manager: 'Pak Joko',
              status: 'Normal',
              produksi: '8.2K pcs',
              revenue: AppFormatters.formatCurrency(80000000),
              statusColor: AppTheme.success,
            ),
            const SizedBox(height: 16),
            _buildBranchCard(
              context,
              name: 'Cabang Bandung',
              manager: 'Bu Rini',
              status: 'Kritis (Overload)',
              produksi: '7.2K pcs',
              revenue: AppFormatters.formatCurrency(45000000),
              statusColor: AppTheme.destructive,
            ),
          ],
        ),
      ),
    ),
  ],
),
    );
  }

  Widget _buildMetricCard(BuildContext context, {required String title, required String value, required IconData icon, required Color color}) {
    return KonveksioCard(
      padding: const EdgeInsets.all(16),
      backgroundColor: color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppTheme.onPrimary, size: 32),
          const SizedBox(height: 16),
          Text(value, style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppTheme.onPrimary)),
          const SizedBox(height: 4),
          Text(title, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppTheme.onPrimary.withOpacity(0.8))),
        ],
      ),
    );
  }

  Widget _buildBranchCard(BuildContext context, {
    required String name,
    required String manager,
    required String status,
    required String produksi,
    required String revenue,
    required Color statusColor,
  }) {
    return KonveksioCard(
      onTap: () {
        // Masuk ke Branch Context Mode (Header Amber)
      },
      padding: const EdgeInsets.all(16),
      child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      name,
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text('Manager: $manager', style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Produksi Bulan Ini', style: Theme.of(context).textTheme.bodySmall),
                        Text(produksi, style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppTheme.primary)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Revenue', style: Theme.of(context).textTheme.bodySmall),
                        Text(revenue, style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppTheme.primary)),
                      ],
                    ),
                  ),
                  Icon(PhosphorIconsRegular.caretRight, color: AppTheme.muted),
                ],
              ),
            ],
          ),
    );
  }
}
