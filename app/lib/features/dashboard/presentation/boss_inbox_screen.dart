import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import '../../../core/theme/app_theme.dart';

class BossInboxScreen extends StatelessWidget {
  const BossInboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Kotak Masuk Resolusi'),
        backgroundColor: AppTheme.surface,
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppTheme.spacingBase),
        children: [
          _buildInboxItem(
            context,
            isUnread: true,
            title: 'Kekurangan QTY Sablon',
            subtitle: 'Dari: Tukang Sablon - SPK-202310-250',
            time: '10:30',
            icon: PhosphorIconsRegular.warningCircle,
            iconColor: AppTheme.warning,
          ),
          const SizedBox(height: AppTheme.spacingSm),
          _buildInboxItem(
            context,
            isUnread: false,
            title: 'Penolakan Handover',
            subtitle: 'Dari: Penjahit Budi - SPK-202310-252',
            time: 'Kemarin',
            icon: PhosphorIconsRegular.xCircle,
            iconColor: AppTheme.destructive,
          ),
          const SizedBox(height: AppTheme.spacingSm),
          _buildInboxItem(
            context,
            isUnread: false,
            title: 'Kain Telah Tiba',
            subtitle: 'Dari: Supplier Kain Toko Laris',
            time: '2 Hari lalu',
            icon: PhosphorIconsRegular.truck,
            iconColor: AppTheme.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildInboxItem(BuildContext context, {
    required bool isUnread,
    required String title,
    required String subtitle,
    required String time,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isUnread ? AppTheme.primary.withOpacity(0.05) : AppTheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(
          color: isUnread ? AppTheme.primary.withOpacity(0.3) : AppTheme.border,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.spacingBase),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: iconColor, size: 24),
                ),
                const SizedBox(width: AppTheme.spacingBase),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: isUnread ? FontWeight.bold : FontWeight.w600,
                          color: isUnread ? AppTheme.foreground : AppTheme.muted,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: isUnread ? AppTheme.foreground.withOpacity(0.8) : AppTheme.muted,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppTheme.spacingSm),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(time, style: TextStyle(fontSize: 12, color: isUnread ? AppTheme.primary : AppTheme.muted)),
                    if (isUnread) ...[
                      const SizedBox(height: 8),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppTheme.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ]
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
