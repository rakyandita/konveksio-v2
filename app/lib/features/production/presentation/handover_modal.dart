import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/konveksio_button.dart';
import '../../../core/widgets/konveksio_text_field.dart';
import 'handover_controller.dart';

class HandoverModal extends ConsumerStatefulWidget {
  final String taskId;
  
  const HandoverModal({
    super.key,
    required this.taskId,
  });

  static void show(BuildContext context, String taskId) {
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
        child: HandoverModal(taskId: taskId),
      ),
    );
  }

  @override
  ConsumerState<HandoverModal> createState() => _HandoverModalState();
}

class _HandoverModalState extends ConsumerState<HandoverModal> {
  final _qtyController = TextEditingController();
  final _notesController = TextEditingController();
  String _selectedReceiver = 'user_siti'; // Dummy default
  
  // In a real app, this would be fetched from Supabase
  final List<Map<String, String>> _receivers = [
    {'id': 'user_siti', 'name': 'Siti (Jahit)'},
    {'id': 'user_anto', 'name': 'Anto (Sablon)'},
    {'id': 'user_vendor', 'name': 'Vendor Eksternal'},
  ];

  @override
  void dispose() {
    _qtyController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _submit() {
    final qtyStr = _qtyController.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (qtyStr.isEmpty) return;
    
    final qty = int.tryParse(qtyStr) ?? 0;
    if (qty <= 0) return;

    ref.read(handoverControllerProvider.notifier).submitHandover(
      taskId: widget.taskId,
      receiverId: _selectedReceiver,
      quantity: qty,
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

    return Padding(
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
              child: DropdownButton<String>(
                value: _selectedReceiver,
                isExpanded: true,
                items: _receivers.map((r) {
                  return DropdownMenuItem<String>(
                    value: r['id']!,
                    child: Text(r['name']!),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val != null) {
                    setState(() => _selectedReceiver = val);
                  }
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          KonveksioTextField(
            label: 'Jumlah Potongan (Pcs)',
            controller: _qtyController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            hintText: 'Contoh: 50',
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
