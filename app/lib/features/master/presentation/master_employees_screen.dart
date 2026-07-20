import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import 'forms/master_employee_form_modal.dart' as import_modal;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/employee_provider.dart';

class MasterEmployeesScreen extends ConsumerWidget {
  const MasterEmployeesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final employeesAsync = ref.watch(employeeListProvider);

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Daftar Karyawan'),
        backgroundColor: AppTheme.surface,
        scrolledUnderElevation: 4.0,
      ),

      body: employeesAsync.when(
        data: (employees) {
          if (employees.isEmpty) {
            return const Center(child: Text('Belum ada data karyawan'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(AppTheme.spacingBase),
            itemCount: employees.length,
            itemBuilder: (context, index) {
              final emp = employees[index];
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
                    child: Icon(PhosphorIconsRegular.user, color: AppTheme.primary),
                  ),
                  title: Text(emp.name, style: Theme.of(context).textTheme.titleSmall),
                  subtitle: Text(emp.role),
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
          import_modal.MasterEmployeeFormModal.show(context);
        },
        backgroundColor: AppTheme.primary,
        child: const Icon(PhosphorIconsRegular.plus, color: AppTheme.background),
      ),
    );
  }
}
