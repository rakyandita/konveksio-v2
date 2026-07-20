import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatters.dart';

class OwnerCabangScreen extends StatelessWidget {
  const OwnerCabangScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Daftar Cabang'),
        backgroundColor: AppTheme.surface,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppTheme.spacingBase),
              child: SearchBar(
                hintText: 'Cari nama cabang...',
                leading: const Icon(PhosphorIconsRegular.magnifyingGlass, color: AppTheme.muted),
                elevation: WidgetStateProperty.all(0),
                backgroundColor: WidgetStateProperty.all(AppTheme.surface),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                    side: const BorderSide(color: AppTheme.border),
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingBase),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildBranchListItem(
                  context,
                  name: 'Cabang Jakarta (Pusat)',
                  address: 'Jl. Sudirman No. 123, Jakarta Selatan',
                  status: 'Aktif',
                  statusColor: AppTheme.success,
                  employeesCount: 45,
                ),
                const SizedBox(height: 16.0),
                _buildBranchListItem(
                  context,
                  name: 'Cabang Bandung',
                  address: 'Jl. Riau No. 45, Bandung',
                  status: 'Aktif',
                  statusColor: AppTheme.success,
                  employeesCount: 28,
                ),
                const SizedBox(height: 16.0),
                _buildBranchListItem(
                  context,
                  name: 'Cabang Surabaya',
                  address: 'Jl. Pemuda No. 88, Surabaya',
                  status: 'Nonaktif',
                  statusColor: AppTheme.muted,
                  employeesCount: 0,
                ),
                const SizedBox(height: 100), // padding for FAB
              ]),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Tampilkan form tambah cabang
        },
        icon: const Icon(PhosphorIconsRegular.plus),
        label: const Text('Cabang Baru'),
        backgroundColor: AppTheme.primary,
        foregroundColor: AppTheme.onPrimary,
      ),
    );
  }

  Widget _buildBranchListItem(BuildContext context, {
    required String name,
    required String address,
    required String status,
    required Color statusColor,
    required int employeesCount,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(color: AppTheme.border),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.spacingBase),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppTheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                  ),
                  child: const Icon(PhosphorIconsRegular.storefront, color: AppTheme.primary),
                ),
                const SizedBox(width: AppTheme.spacingBase),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
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
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: statusColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              status,
                              style: TextStyle(color: statusColor, fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        address,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppTheme.muted),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(PhosphorIconsRegular.users, size: 14, color: AppTheme.muted),
                          const SizedBox(width: 4),
                          Text(
                            '$employeesCount Karyawan',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppTheme.muted),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16.0),
                const Icon(PhosphorIconsRegular.caretRight, color: AppTheme.muted),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
