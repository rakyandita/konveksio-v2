import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import 'forms/master_employee_form_modal.dart' as import_modal;

class MasterEmployeesScreen extends StatelessWidget {
  const MasterEmployeesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mockEmployees = [
      {'name': 'Budi Santoso', 'division': 'Jahit', 'role': 'Karyawan'},
      {'name': 'Siti Aminah', 'division': 'Finishing', 'role': 'Karyawan'},
      {'name': 'Agus', 'division': 'Potong', 'role': 'Karyawan'},
    ];

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Daftar Karyawan'),
        backgroundColor: AppTheme.surface,
        scrolledUnderElevation: 4.0,
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(AppTheme.spacingBase),
        itemCount: mockEmployees.length,
        itemBuilder: (context, index) {
          final emp = mockEmployees[index];
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
              title: Text(emp['name']!, style: Theme.of(context).textTheme.titleSmall),
              subtitle: Text(emp['role']!),
              trailing: Chip(
                label: Text(emp['division']!),
                backgroundColor: AppTheme.background,
                side: const BorderSide(color: AppTheme.border),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          import_modal.MasterEmployeeFormModal.show(context);
        },
        backgroundColor: AppTheme.primary,
        child: const Icon(PhosphorIconsRegular.plus, color: AppTheme.background),
      ),
    );
  }
}
