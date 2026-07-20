import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/konveksio_button.dart';
import '../../../../core/utils/formatters.dart';
import '../../dashboard/presentation/karyawan_completed_tasks_controller.dart';

class KaryawanSelesaiDetailModal {
  static void show(BuildContext context, {required CompletedTaskItem item}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _KaryawanSelesaiDetailModalContent(item: item),
    );
  }
}

class _KaryawanSelesaiDetailModalContent extends StatelessWidget {
  final CompletedTaskItem item;

  const _KaryawanSelesaiDetailModalContent({required this.item});

  @override
  Widget build(BuildContext context) {
    final dateStr = AppFormatters.formatDate(item.completedAt);
    return Container(
      decoration: const BoxDecoration(
        color: AppTheme.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppTheme.radiusLg)),
      ),
      padding: const EdgeInsets.only(
        left: AppTheme.spacingBase,
        right: AppTheme.spacingBase,
        top: AppTheme.spacingBase,
        bottom: AppTheme.spacingXl,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Detail Serah Terima', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
              IconButton(
                icon: const Icon(PhosphorIconsRegular.x),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingSm),
          Text(item.productName, style: Theme.of(context).textTheme.titleMedium),
          Text('Klien: ${item.customerName ?? '-'}', style: const TextStyle(color: AppTheme.muted)),
          Text('Selesai pada: $dateStr', style: const TextStyle(color: AppTheme.muted)),
          
          const SizedBox(height: AppTheme.spacingLg),
          const Text('Alur Pekerjaan', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: AppTheme.spacingSm),
          
          Container(
            padding: const EdgeInsets.all(AppTheme.spacingBase),
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              border: Border.all(color: AppTheme.border),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(PhosphorIconsRegular.arrowUpRight, color: AppTheme.success),
                    const SizedBox(width: AppTheme.spacingSm),
                    const Expanded(child: Text('Diserahkan ke:', style: TextStyle(color: AppTheme.muted))),
                    Text(item.handedOverTo, style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(height: AppTheme.spacingLg),
          const Text('Rincian Kuantitas Selesai', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: AppTheme.spacingSm),
          
          Container(
            padding: const EdgeInsets.all(AppTheme.spacingBase),
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              border: Border.all(color: AppTheme.border),
            ),
            child: Wrap(
              alignment: WrapAlignment.spaceAround,
              spacing: 16,
              runSpacing: 16,
              children: item.handoverSizes.entries.map((e) {
                return _buildSizeBox(e.key, e.value.toString());
              }).toList(),
            ),
          ),
          
          const SizedBox(height: AppTheme.spacingLg),
          KonveksioButton(
            text: 'Tutup',
            type: KonveksioButtonType.secondary,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildSizeBox(String size, String qty) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(size, style: const TextStyle(color: AppTheme.muted, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(qty, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
