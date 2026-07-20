import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import '../../../core/theme/app_theme.dart';
import 'forms/master_customer_form_modal.dart' as import_modal;

class MasterCustomersScreen extends StatelessWidget {
  const MasterCustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mockCustomers = [
      {'name': 'PT Maju Bersama', 'contact': 'Pak Andi', 'phone': '08123456789'},
      {'name': 'SMA 1 Jakarta', 'contact': 'Ibu Ani', 'phone': '08987654321'},
    ];

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Daftar Customer'),
        backgroundColor: AppTheme.surface,
        scrolledUnderElevation: 4.0,
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(AppTheme.spacingBase),
        itemCount: mockCustomers.length,
        itemBuilder: (context, index) {
          final cust = mockCustomers[index];
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
              title: Text(cust['name']!, style: Theme.of(context).textTheme.titleSmall),
              subtitle: Text('${cust['contact']} - ${cust['phone']}'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          import_modal.MasterCustomerFormModal.show(context);
        },
        backgroundColor: AppTheme.primary,
        child: const Icon(PhosphorIconsRegular.plus, color: AppTheme.background),
      ),
    );
  }
}
