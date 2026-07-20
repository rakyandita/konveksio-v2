import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/konveksio_button.dart';

class BossAssignScreen extends ConsumerStatefulWidget {
  const BossAssignScreen({super.key});

  @override
  ConsumerState<BossAssignScreen> createState() => _BossAssignScreenState();
}

class _BossAssignScreenState extends ConsumerState<BossAssignScreen> {
  final List<String> _divisions = ['Potong', 'Jahit', 'Sablon', 'Bordir', 'Finishing'];
  String? _selectedDivision;
  
  final Map<String, int> _assignedQty = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Smart Bulk Assign'),
        backgroundColor: AppTheme.surface,
        scrolledUnderElevation: 4.0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingBase),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingBase),
              decoration: BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                border: Border.all(color: AppTheme.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Informasi Pekerjaan',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: AppTheme.spacingBase),
                  Text('Item: Kemeja PDL (ORD-001)', style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: AppTheme.spacingSm),
                  Text('Total Target: 50 pcs', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.spacingBase),
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingBase),
              decoration: BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                border: Border.all(color: AppTheme.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pilih Divisi',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: AppTheme.spacingSm),
                  DropdownButtonFormField<String>(
                    value: _selectedDivision,
                    decoration: const InputDecoration(
                      hintText: 'Pilih Divisi Kerja',
                    ),
                    items: _divisions.map((div) {
                      return DropdownMenuItem(
                        value: div,
                        child: Text(div),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedDivision = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.spacingBase),
            if (_selectedDivision != null) _buildEmployeesList(),
            const SizedBox(height: AppTheme.spacingLg),
            KonveksioButton(
              text: 'KONFIRMASI ASSIGN TUGAS',
              onPressed: () {
                int totalAssigned = _assignedQty.values.fold(0, (sum, val) => sum + val);
                if (totalAssigned == 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Masukkan qty assign untuk setidaknya 1 karyawan')),
                  );
                  return;
                }
                
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Berhasil assign $totalAssigned pcs ke $_selectedDivision')),
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmployeesList() {
    // Data mock karyawan sesuai divisi
    final employees = ['Budi', 'Andi', 'Siti'];
    
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingBase),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(color: AppTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Karyawan $_selectedDivision',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: AppTheme.spacingBase),
          ...employees.map((emp) {
            final qty = _assignedQty[emp] ?? 0;
            return Padding(
              padding: const EdgeInsets.only(bottom: AppTheme.spacingSm),
              child: Row(
                children: [
                  Expanded(
                    child: Text(emp, style: Theme.of(context).textTheme.bodyMedium),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline, color: AppTheme.muted),
                        onPressed: () {
                          if (qty > 0) {
                            setState(() => _assignedQty[emp] = qty - 10);
                          }
                        },
                      ),
                      Container(
                        width: 40,
                        alignment: Alignment.center,
                        child: Text(
                          '$qty',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline, color: AppTheme.primary),
                        onPressed: () {
                          setState(() => _assignedQty[emp] = qty + 10);
                        },
                      ),
                    ],
                  )
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
