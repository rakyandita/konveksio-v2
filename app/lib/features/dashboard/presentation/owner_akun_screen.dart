import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import '../../../core/theme/app_theme.dart';

class OwnerAkunScreen extends StatelessWidget {
  const OwnerAkunScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingBase),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const Text(
                  'Daftar Pengguna',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 16.0),
                _buildUserListItem(
                  context,
                  name: 'Budi Santoso',
                  email: 'budi@konveksio.id',
                  role: 'Boss Cabang',
                  branch: 'Cabang Jakarta (Pusat)',
                  status: 'Aktif',
                ),
                const Divider(),
                _buildUserListItem(
                  context,
                  name: 'Rina Kusuma',
                  email: 'rina@konveksio.id',
                  role: 'Admin',
                  branch: 'Cabang Jakarta (Pusat)',
                  status: 'Aktif',
                ),
                const Divider(),
                _buildUserListItem(
                  context,
                  name: 'Joko Anwar',
                  email: 'joko@konveksio.id',
                  role: 'Boss Cabang',
                  branch: 'Cabang Bandung',
                  status: 'Aktif',
                ),
                const Divider(),
                _buildUserListItem(
                  context,
                  name: 'Siti Aminah',
                  email: 'siti@konveksio.id',
                  role: 'Admin',
                  branch: 'Cabang Bandung',
                  status: 'Nonaktif',
                ),
                const SizedBox(height: 100), // padding for FAB
              ]),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Tampilkan form tambah akun
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
          name.substring(0, 1).toUpperCase(),
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
      onTap: () {},
    );
  }
}
