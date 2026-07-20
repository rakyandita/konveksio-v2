import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import '../../../core/theme/app_theme.dart';
import 'karyawan_salary_controller.dart';

class KaryawanSalaryScreen extends ConsumerWidget {
  const KaryawanSalaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final salaryAsync = ref.watch(karyawanSalaryControllerProvider);

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Riwayat Slip Gaji'),
        backgroundColor: AppTheme.surface,
        scrolledUnderElevation: 4.0,
      ),
      body: salaryAsync.when(
        data: (salaries) {
          if (salaries.isEmpty) {
            return const Center(
              child: Text(
                'Belum ada riwayat gaji.',
                style: TextStyle(color: AppTheme.muted),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(AppTheme.spacingBase),
            itemCount: salaries.length,
            itemBuilder: (context, index) {
              final salary = salaries[index];
              return _buildSalaryCard(context, salary);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text(
            'Terjadi kesalahan: $error',
            style: const TextStyle(color: AppTheme.destructive),
          ),
        ),
      ),
    );
  }

  Widget _buildSalaryCard(BuildContext context, SalaryRecord salary) {
    return Card(
      elevation: 0,
      color: AppTheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        side: const BorderSide(color: AppTheme.border),
      ),
      margin: const EdgeInsets.only(bottom: AppTheme.spacingBase),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingBase),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppTheme.success.withValues(alpha: 0.1),
                  child: const Icon(PhosphorIconsRegular.receipt, color: AppTheme.success),
                ),
                const SizedBox(width: AppTheme.spacingBase),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Periode ${salary.periodStartDate} - ${salary.periodEndDate}',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        salary.date,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.muted,
                            ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'Rp ${salary.netPay}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.success,
                      ),
                ),
              ],
            ),
            const Divider(height: 24),
            _buildDetailRow('Gaji Pokok', 'Rp ${salary.basePay}'),
            const SizedBox(height: 8),
            _buildDetailRow('Piece-rate (Borongan)', 'Rp ${salary.pieceRatePay}'),
            if (salary.deductions > 0) ...[
              const SizedBox(height: 8),
              _buildDetailRow('Potongan (Kasbon dll)', '-Rp ${salary.deductions}', isDeduction: true),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isDeduction = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: AppTheme.muted)),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: isDeduction ? AppTheme.destructive : AppTheme.foreground,
          ),
        ),
      ],
    );
  }
}
