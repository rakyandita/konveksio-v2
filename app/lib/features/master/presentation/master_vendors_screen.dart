import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import 'forms/master_vendor_form_modal.dart' as import_modal;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/vendor_provider.dart';

class MasterVendorsScreen extends ConsumerWidget {
  const MasterVendorsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vendorsAsync = ref.watch(vendorListProvider);

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Daftar Vendor/Makloon'),
        backgroundColor: AppTheme.surface,
        scrolledUnderElevation: 4.0,
      ),

      body: vendorsAsync.when(
        data: (vendors) {
          if (vendors.isEmpty) {
            return const Center(child: Text('Belum ada data vendor'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(AppTheme.spacingBase),
            itemCount: vendors.length,
            itemBuilder: (context, index) {
              final vendor = vendors[index];
              return Card(
                elevation: 0,
                color: AppTheme.surface,
                margin: const EdgeInsets.only(bottom: AppTheme.spacingBase),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                  side: const BorderSide(color: AppTheme.border),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(AppTheme.spacingBase),
                  leading: const CircleAvatar(
                    backgroundColor: AppTheme.background,
                    child: Icon(PhosphorIconsRegular.factory, color: AppTheme.primary),
                  ),
                  title: Text(vendor.name, style: Theme.of(context).textTheme.titleSmall),
                  subtitle: Text('${vendor.division} - ${vendor.phone ?? '-'}'),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Terjadi kesalahan: $error')),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () {
          import_modal.MasterVendorFormModal.show(context);
        },
        backgroundColor: AppTheme.primary,
        child: const Icon(PhosphorIconsRegular.plus, color: AppTheme.background),
      ),
    );
  }
}
