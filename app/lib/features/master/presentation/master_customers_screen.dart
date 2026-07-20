import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import '../../../core/theme/app_theme.dart';
import 'forms/master_customer_form_modal.dart' as import_modal;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/customer_provider.dart';

class MasterCustomersScreen extends ConsumerWidget {
  const MasterCustomersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customersAsync = ref.watch(customerListProvider);

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Daftar Customer'),
        backgroundColor: AppTheme.surface,
        scrolledUnderElevation: 4.0,
      ),

      body: customersAsync.when(
        data: (customers) {
          if (customers.isEmpty) {
            return const Center(child: Text('Belum ada data customer'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(AppTheme.spacingBase),
            itemCount: customers.length,
            itemBuilder: (context, index) {
              final cust = customers[index];
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
                    child: Icon(PhosphorIconsRegular.users, color: AppTheme.primary),
                  ),
                  title: Text(cust.name, style: Theme.of(context).textTheme.titleSmall),
                  subtitle: Text('${cust.phone ?? '-'}'),
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
          import_modal.MasterCustomerFormModal.show(context);
        },
        backgroundColor: AppTheme.primary,
        child: const Icon(PhosphorIconsRegular.plus, color: AppTheme.background),
      ),
    );
  }
}
