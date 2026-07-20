import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/konveksio_card.dart';

class BossDashboardScreen extends ConsumerStatefulWidget {
  const BossDashboardScreen({super.key});

  @override
  ConsumerState<BossDashboardScreen> createState() => _BossDashboardScreenState();
}

class _BossDashboardScreenState extends ConsumerState<BossDashboardScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 10 && !_isScrolled) {
        setState(() {
          _isScrolled = true;
        });
      } else if (_scrollController.offset <= 10 && _isScrolled) {
        setState(() {
          _isScrolled = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            title: const Text('Dashboard Cabang'),
            backgroundColor: _isScrolled ? AppTheme.surface : AppTheme.background,
            surfaceTintColor: Colors.transparent,
            shadowColor: Colors.black.withOpacity(0.15),
            pinned: true,
            forceElevated: _isScrolled,
            elevation: 0,
            scrolledUnderElevation: 4.0,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
            // Alert Box
            InkWell(
              onTap: () => context.push('/boss/finance/kasbon'),
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.destructive.withValues(alpha: 0.1),
                  border: Border.all(color: AppTheme.destructive),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(PhosphorIconsRegular.warning, color: AppTheme.destructive),
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
                            'Ada 3 pengajuan kasbon yang menunggu persetujuan. Klik untuk melihat.',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppTheme.destructive),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _buildMenuGrid(context),
            const SizedBox(height: AppTheme.spacingLg),
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
                    icon: PhosphorIconsRegular.package,
                    color: AppTheme.primary,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildBentoCard(
                    context,
                    title: 'Produksi Selesai',
                    value: '450 pcs',
                    icon: PhosphorIconsRegular.checkCircle,
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
                    icon: PhosphorIconsRegular.users,
                    color: AppTheme.secondary,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildBentoCard(
                    context,
                    title: 'Kasbon Tertunda',
                    value: AppFormatters.formatCurrency(1500000),
                    icon: PhosphorIconsRegular.money,
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
                _buildQuickAction(context, 'Buat SPK', PhosphorIconsRegular.filePlus),
                _buildQuickAction(context, 'Terima Setoran', PhosphorIconsRegular.wallet),
                _buildQuickAction(context, 'Data Karyawan', PhosphorIconsRegular.addressBook),
              ],
            )
          ],
        ),
      ),
    ),
  ],
),
    );
  }

  Widget _buildBentoCard(BuildContext context, {required String title, required String value, required IconData icon, required Color color}) {
    return KonveksioCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color),
              Icon(PhosphorIconsRegular.arrowUpRight, size: 16, color: AppTheme.muted),
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

  Widget _buildMenuGrid(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 8,
      children: [
        _buildMenuIcon(context, 'Kotak Masuk', PhosphorIconsRegular.tray, () => context.push('/boss/inbox')),
        _buildMenuIcon(context, 'Kasbon', PhosphorIconsRegular.money, () => context.push('/boss/finance/kasbon')),
        _buildMenuIcon(context, 'Gaji', PhosphorIconsRegular.wallet, () => context.push('/boss/finance/salary')),
        _buildMenuIcon(context, 'Karyawan', PhosphorIconsRegular.users, () => context.push('/boss/master/employees')),
        _buildMenuIcon(context, 'Produk', PhosphorIconsRegular.tShirt, () => context.push('/boss/master/products')),
        _buildMenuIcon(context, 'Vendor', PhosphorIconsRegular.buildings, () => context.push('/boss/master/vendors')),
        _buildMenuIcon(context, 'Customer', PhosphorIconsRegular.addressBook, () => context.push('/boss/master/customers')),
        _buildMenuIcon(context, 'Laporan', PhosphorIconsRegular.chartBar, () {}),
      ],
    );
  }

  Widget _buildMenuIcon(BuildContext context, String label, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppTheme.radiusMd),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppTheme.primary, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
