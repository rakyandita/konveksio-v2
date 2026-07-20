import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/konveksio_button.dart';

class KaryawanSelesaiDetailModal {
  static void show(BuildContext context, {required String taskName, required String date}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _KaryawanSelesaiDetailModalContent(taskName: taskName, date: date),
    );
  }
}

class _KaryawanSelesaiDetailModalContent extends StatelessWidget {
  final String taskName;
  final String date;

  const _KaryawanSelesaiDetailModalContent({required this.taskName, required this.date});

  @override
  Widget build(BuildContext context) {
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
          Text(taskName, style: Theme.of(context).textTheme.titleMedium),
          Text('Selesai pada: $date', style: const TextStyle(color: AppTheme.muted)),
          
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
                    const Icon(PhosphorIconsRegular.arrowDownLeft, color: AppTheme.muted),
                    const SizedBox(width: AppTheme.spacingSm),
                    const Expanded(child: Text('Diterima dari:', style: TextStyle(color: AppTheme.muted))),
                    Text('Divisi Cutting (Andi)', style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: AppTheme.spacingSm),
                  child: Divider(height: 1),
                ),
                Row(
                  children: [
                    const Icon(PhosphorIconsRegular.arrowUpRight, color: AppTheme.success),
                    const SizedBox(width: AppTheme.spacingSm),
                    const Expanded(child: Text('Diserahkan ke:', style: TextStyle(color: AppTheme.muted))),
                    Text('Divisi Sablon (Tono)', style: const TextStyle(fontWeight: FontWeight.bold)),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildSizeBox('S', '20'),
                _buildSizeBox('M', '40'),
                _buildSizeBox('L', '30'),
                _buildSizeBox('XL', '10'),
              ],
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
      children: [
        Text(size, style: const TextStyle(color: AppTheme.muted, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(qty, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
