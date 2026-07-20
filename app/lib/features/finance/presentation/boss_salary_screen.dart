import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/konveksio_button.dart';
import 'boss_salary_controller.dart';

class BossSalaryScreen extends ConsumerStatefulWidget {
  const BossSalaryScreen({super.key});

  @override
  ConsumerState<BossSalaryScreen> createState() => _BossSalaryScreenState();
}

class _BossSalaryScreenState extends ConsumerState<BossSalaryScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Penggajian'),
        backgroundColor: AppTheme.surface,
        scrolledUnderElevation: 4.0,
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppTheme.primary,
          unselectedLabelColor: AppTheme.muted,
          indicatorColor: AppTheme.primary,
          tabs: const [
            Tab(text: 'GENERATE BARU'),
            Tab(text: 'RIWAYAT GAJI'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildGenerateBaruTab(context),
          _buildRiwayatGajiTab(context),
        ],
      ),
    );
  }

  Widget _buildGenerateBaruTab(BuildContext context) {
    final state = ref.watch(bossSalaryControllerProvider);

    return SingleChildScrollView(
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
          _buildSalaryCard(context, 'Budi Santoso', 'Jahit', '500.000', '150.000', '350.000'),
          _buildSalaryCard(context, 'Siti Aminah', 'Finishing', '300.000', '0', '300.000'),
          const SizedBox(height: AppTheme.spacingLg),
          KonveksioButton(
            text: 'GENERATE SLIP GAJI & SIMPAN',
            isLoading: state.isLoading,
            onPressed: () async {
              await ref.read(bossSalaryControllerProvider.notifier).generateSalary();
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Slip gaji berhasil dibuat untuk periode ini')),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRiwayatGajiTab(BuildContext context) {
    final state = ref.watch(bossSalaryControllerProvider);
    final currencyFormat = NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);
    final shortDateFormat = DateFormat('dd MMM yyyy', 'id');

    if (state.isLoading && state.history.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.history.isEmpty) {
      return const Center(
        child: Text(
          'Belum ada riwayat gaji.',
          style: TextStyle(color: AppTheme.muted),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppTheme.spacingBase),
      itemCount: state.history.length,
      itemBuilder: (context, index) {
        final record = state.history[index];
        final startDate = record.periodEnd.subtract(const Duration(days: 6));
        final period = '${shortDateFormat.format(startDate)} - ${shortDateFormat.format(record.periodEnd)}';
        
        return _buildHistoryCard(context, period, 'Total: ${currencyFormat.format(record.netSalary)} (${record.userId})');
      },
    );
  }

  Widget _buildHistoryCard(BuildContext context, String period, String summary) {
    return Card(
      elevation: 0,
      color: AppTheme.surface,
      margin: const EdgeInsets.only(bottom: AppTheme.spacingSm),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        side: const BorderSide(color: AppTheme.border),
      ),
      child: ListTile(
        title: Text(period, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(summary, style: const TextStyle(color: AppTheme.muted)),
        trailing: const Icon(PhosphorIconsRegular.filePdf, color: AppTheme.primary),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Membuka detail slip gaji...')),
          );
        },
      ),
    );
  }

  Widget _buildSalaryCard(BuildContext context, String name, String div, String pokok, String potongan, String total) {
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
            if (potongan != '0')
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
