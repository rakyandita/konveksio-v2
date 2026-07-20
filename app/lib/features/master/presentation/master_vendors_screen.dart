import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import 'forms/master_vendor_form_modal.dart' as import_modal;

class MasterVendorsScreen extends StatelessWidget {
  const MasterVendorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mockVendors = [
      {'name': 'Vendor A (Sablon)', 'phone': '08123456789', 'status': 'Aktif'},
      {'name': 'Vendor B (Bordir)', 'phone': '08987654321', 'status': 'Aktif'},
    ];

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Daftar Vendor Eksternal'),
        backgroundColor: AppTheme.surface,
        scrolledUnderElevation: 4.0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.primary,
        onPressed: () {},
        child: const Icon(PhosphorIconsRegular.plus, color: AppTheme.onPrimary),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(AppTheme.spacingBase),
        itemCount: mockVendors.length,
        itemBuilder: (context, index) {
          final vendor = mockVendors[index];
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
                child: Icon(PhosphorIconsRegular.buildings, color: AppTheme.primary),
              ),
              title: Text(vendor['name']!, style: Theme.of(context).textTheme.titleSmall),
              subtitle: Text(vendor['phone']!),
              trailing: Chip(
                label: Text(vendor['status']!),
                backgroundColor: AppTheme.success.withOpacity(0.1),
                labelStyle: const TextStyle(color: AppTheme.success),
                side: BorderSide.none,
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          import_modal.MasterVendorFormModal.show(context);
        },
        backgroundColor: AppTheme.primary,
        child: const Icon(PhosphorIconsRegular.plus, color: AppTheme.background),
      ),
    );
  }
}
