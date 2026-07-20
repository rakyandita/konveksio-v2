import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import '../../../core/theme/app_theme.dart';
import 'forms/owner_branch_form_modal.dart' as import_modal;
import 'owner_cabang_controller.dart';

class OwnerCabangScreen extends ConsumerWidget {
  const OwnerCabangScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(ownerCabangControllerProvider);

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
          if (state.isLoading)
            const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            )
          else if (state.branches.isEmpty)
            const SliverFillRemaining(
              child: Center(child: Text('Belum ada cabang. Tambahkan cabang baru.')),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingBase),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index == state.branches.length) {
                      return const SizedBox(height: 100); // padding for FAB
                    }
                    final branch = state.branches[index];
                    final isActive = branch['is_active'] as bool? ?? false;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: _buildBranchListItem(
                        context,
                        name: branch['name'] as String? ?? 'Tanpa Nama',
                        address: branch['address'] as String? ?? 'Tanpa Alamat',
                        status: isActive ? 'Aktif' : 'Nonaktif',
                        statusColor: isActive ? AppTheme.success : AppTheme.muted,
                        employeesCount: 0, // Mock count, update in real query
                      ),
                    );
                  },
                  childCount: state.branches.length + 1,
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: null,
        onPressed: () {
          import_modal.OwnerBranchFormModal.show(context);
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
          onTap: () {
            import_modal.OwnerBranchFormModal.show(context);
          },
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
