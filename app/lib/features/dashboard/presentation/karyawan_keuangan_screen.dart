import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import '../../../core/theme/app_theme.dart';

class KaryawanKeuanganScreen extends StatelessWidget {
  const KaryawanKeuanganScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Keuangan'),
        backgroundColor: AppTheme.surface,
        scrolledUnderElevation: 4.0,
        shadowColor: const Color(0x26000000),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppTheme.spacingBase),
        children: [
          _buildMenuCard(
            context,
            title: 'Pengajuan Kasbon',
            subtitle: 'Ajukan pinjaman kasbon baru',
            icon: PhosphorIconsRegular.money,
            onTap: () => context.push('/karyawan/kasbon'),
          ),
          const SizedBox(height: AppTheme.spacingSm),
          _buildMenuCard(
            context,
            title: 'Slip Gaji',
            subtitle: 'Lihat riwayat gaji Anda (Segera Hadir)',
            icon: PhosphorIconsRegular.receipt,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Fitur Slip Gaji belum tersedia')),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 0,
      color: AppTheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        side: const BorderSide(color: AppTheme.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacingBase),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppTheme.spacingSm),
                decoration: BoxDecoration(
                  color: AppTheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                ),
                child: Icon(icon, color: AppTheme.primary, size: 28),
              ),
              const SizedBox(width: AppTheme.spacingBase),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppTheme.muted,
                          ),
                    ),
                  ],
                ),
              ),
              const Icon(PhosphorIconsRegular.caretRight, color: AppTheme.muted),
            ],
          ),
        ),
      ),
    );
  }
}
