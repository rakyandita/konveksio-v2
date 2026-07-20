import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import '../../../core/theme/app_theme.dart';
import 'forms/owner_account_form_modal.dart';
import 'owner_akun_controller.dart';

class OwnerAkunScreen extends ConsumerWidget {
  const OwnerAkunScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(ownerAkunControllerProvider);

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Akun & Akses'),
        backgroundColor: AppTheme.surface,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppTheme.spacingBase),
              child: SearchBar(
                hintText: 'Cari nama atau email...',
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
          else if (state.profiles.isEmpty)
            const SliverFillRemaining(
              child: Center(child: Text('Belum ada pengguna.')),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingBase),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index == state.profiles.length) {
                      return const SizedBox(height: 100); // padding for FAB
                    }
                    final profile = state.profiles[index];
                    final name = profile['name'] as String? ?? 'Tanpa Nama';
                    final role = profile['role'] as String? ?? 'Employee';
                    final isActive = profile['is_active'] as bool? ?? false;
                    
                    String branch = 'Tanpa Cabang';
                    if (profile['branches'] != null && profile['branches']['name'] != null) {
                      branch = profile['branches']['name'];
                    }

                    return Column(
                      children: [
                        _buildUserListItem(
                          context,
                          name: name,
                          email: 'Login menggunakan PIN',
                          role: role.toUpperCase(),
                          branch: branch,
                          status: isActive ? 'Aktif' : 'Nonaktif',
                        ),
                        if (index < state.profiles.length - 1) const Divider(),
                      ],
                    );
                  },
                  childCount: state.profiles.length + 1,
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: null,
        onPressed: () {
          OwnerAccountFormModal.show(context);
        },
        icon: const Icon(PhosphorIconsRegular.userPlus),
        label: const Text('Tambah Akun'),
        backgroundColor: AppTheme.primary,
        foregroundColor: AppTheme.onPrimary,
      ),
    );
  }

  Widget _buildUserListItem(BuildContext context, {
    required String name,
    required String email,
    required String role,
    required String branch,
    required String status,
  }) {
    final bool isActive = status == 'Aktif';
    
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: isActive ? AppTheme.primary.withOpacity(0.1) : AppTheme.muted.withOpacity(0.2),
        child: Text(
          name.isNotEmpty ? name.substring(0, 1).toUpperCase() : '?',
          style: TextStyle(
            color: isActive ? AppTheme.primary : AppTheme.muted,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Text(name, style: Theme.of(context).textTheme.titleMedium?.copyWith(
        color: isActive ? AppTheme.foreground : AppTheme.muted,
      )),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(email, style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 4),
          Wrap(
            spacing: 8,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppTheme.secondary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(role, style: const TextStyle(color: AppTheme.secondary, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppTheme.border,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(branch, style: const TextStyle(color: AppTheme.muted, fontSize: 10)),
              ),
              if (!isActive)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppTheme.muted.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text('Nonaktif', style: TextStyle(color: AppTheme.muted, fontSize: 10)),
                ),
            ],
          ),
        ],
      ),
      trailing: const Icon(PhosphorIconsRegular.caretRight, color: AppTheme.muted),
      onTap: () {
        OwnerAccountFormModal.show(context);
      },
    );
  }
}
