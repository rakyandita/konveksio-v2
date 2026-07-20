import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/konveksio_button.dart';
import '../../../core/widgets/konveksio_size_input.dart';
import '../../../core/widgets/konveksio_text_field.dart';
import '../../master/presentation/providers/employee_provider.dart';
import 'handover_controller.dart';

class HandoverModal extends ConsumerStatefulWidget {
  final String taskId;
  final List<String> availableSizes;
  
  const HandoverModal({
    super.key,
    required this.taskId,
    required this.availableSizes,
  });

  static void show(BuildContext context, String taskId, {List<String>? sizes}) {
    final availableSizes = sizes ?? ['S', 'M', 'L'];
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppTheme.radiusLg)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: HandoverModal(taskId: taskId, availableSizes: availableSizes),
      ),
    );
  }

  @override
  ConsumerState<HandoverModal> createState() => _HandoverModalState();
}

class _HandoverModalState extends ConsumerState<HandoverModal> {
  late final Map<String, TextEditingController> _sizeControllers;
  
  @override
  void initState() {
    super.initState();
    _sizeControllers = {
      for (var size in widget.availableSizes) size: TextEditingController()
    };
  }

  final _notesController = TextEditingController();
  String? _selectedReceiver;

  @override
  void dispose() {
    for (var controller in _sizeControllers.values) {
      controller.dispose();
    }
    _notesController.dispose();
    super.dispose();
  }

  void _submit() {
    final Map<String, int> sizes = {};
    for (var entry in _sizeControllers.entries) {
      final qtyStr = entry.value.text.replaceAll(RegExp(r'[^0-9]'), '');
      final qty = int.tryParse(qtyStr) ?? 0;
      if (qty > 0) {
        sizes[entry.key] = qty;
      }
    }
    
    if (sizes.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Masukkan setidaknya 1 qty pada ukuran'),
          backgroundColor: AppTheme.destructive,
        ),
      );
      return;
    }

    if (_selectedReceiver == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pilih penerima tugas terlebih dahulu'),
          backgroundColor: AppTheme.warning,
        ),
      );
      return;
    }

    ref.read(handoverControllerProvider.notifier).submitHandover(
      taskId: widget.taskId,
      receiverId: _selectedReceiver!,
      sizes: sizes,
      notes: _notesController.text.isNotEmpty ? _notesController.text : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(handoverControllerProvider);
    
    ref.listen(handoverControllerProvider, (previous, next) {
      if (next.isSuccess) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Berhasil menyerahkan tugas'),
            backgroundColor: AppTheme.success,
          ),
        );
      }
    });

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Serah Terima Tugas',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          Text('Penerima', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: AppTheme.border),
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
            ),
            child: DropdownButtonHideUnderline(
              child: ref.watch(employeeListProvider).when(
                data: (employees) {
                  if (employees.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text('Tidak ada karyawan tersedia'),
                    );
                  }
                  
                  // Reset selected receiver if not in list
                  if (_selectedReceiver != null && !employees.any((e) => e.id == _selectedReceiver)) {
                    _selectedReceiver = null;
                  }
                  if (_selectedReceiver == null && employees.isNotEmpty) {
                    _selectedReceiver = employees.first.id;
                  }

                  return DropdownButton<String>(
                    value: _selectedReceiver,
                    isExpanded: true,
                    hint: const Text('Pilih Karyawan'),
                    items: employees.map((employee) {
                      return DropdownMenuItem<String>(
                        value: employee.id,
                        child: Text('${employee.name} (${employee.role.toUpperCase()})'),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setState(() => _selectedReceiver = val);
                      }
                    },
                  );
                },
                loading: () => const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (err, _) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text('Error: $err', style: const TextStyle(color: AppTheme.destructive)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          Text('Kuantitas (Pcs)', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: AppTheme.border),
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                // 4 kolom, 3 jarak @ 12px = 36px total spasi horizontal
                final itemWidth = (constraints.maxWidth - 36) / 4 - 0.1;
                return Wrap(
                  spacing: 12,
                  runSpacing: 16,
                  children: _sizeControllers.entries.map((entry) {
                    return SizedBox(
                      width: itemWidth,
                      child: KonveksioSizeInput(
                        sizeLabel: entry.key,
                        controller: entry.value,
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          
          KonveksioTextField(
            label: 'Catatan (Opsional)',
            controller: _notesController,
            maxLines: 3,
            hintText: 'Tambahkan keterangan kondisi barang...',
          ),
          
          if (state.error != null) ...[
            const SizedBox(height: 16),
            Text(
              state.error!,
              style: const TextStyle(color: AppTheme.destructive),
            ),
          ],
          
          const SizedBox(height: 24),
          KonveksioButton(
            text: 'SERAHKAN TUGAS',
            onPressed: state.isLoading ? null : _submit,
            isLoading: state.isLoading,
          ),
          // Give some padding at the bottom for safety
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
