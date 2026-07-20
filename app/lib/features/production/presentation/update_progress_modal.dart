import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/konveksio_button.dart';
import '../../../core/widgets/konveksio_size_input.dart';
import 'update_progress_controller.dart';

class UpdateProgressModal extends ConsumerStatefulWidget {
  final String taskId;
  final Map<String, int> targets;

  const UpdateProgressModal({
    super.key,
    required this.taskId,
    required this.targets,
  });

  static void show(BuildContext context, String taskId, Map<String, int> targets) {
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
        child: UpdateProgressModal(taskId: taskId, targets: targets),
      ),
    );
  }

  @override
  ConsumerState<UpdateProgressModal> createState() => _UpdateProgressModalState();
}

class _UpdateProgressModalState extends ConsumerState<UpdateProgressModal> {
  late final Map<String, TextEditingController> _sizeControllers;

  @override
  void initState() {
    super.initState();
    _sizeControllers = {
      for (var size in widget.targets.keys) size: TextEditingController()
    };
  }

  @override
  void dispose() {
    for (var controller in _sizeControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _submit() {
    final Map<String, int> inputs = {};
    for (var entry in _sizeControllers.entries) {
      final qtyStr = entry.value.text.replaceAll(RegExp(r'[^0-9]'), '');
      final qty = int.tryParse(qtyStr) ?? 0;
      if (qty > 0) {
        inputs[entry.key] = qty;
      }
    }
    
    // We do quick frontend check for empty inputs before hitting controller to show snackbar quickly
    if (inputs.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Masukkan setidaknya 1 qty pada ukuran'),
          backgroundColor: AppTheme.destructive,
        ),
      );
      return;
    }

    ref.read(updateProgressControllerProvider.notifier).submitProgress(
      widget.taskId,
      inputs,
      widget.targets,
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(updateProgressControllerProvider);

    ref.listen(updateProgressControllerProvider, (previous, next) {
      if (next.isSuccess) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Berhasil menyimpan progres'),
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
                'Update Progres',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Masukkan jumlah pcs yang telah diselesaikan. Tidak boleh melebihi sisa target.',
            style: TextStyle(color: AppTheme.muted),
          ),
          const SizedBox(height: 24),
          
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: AppTheme.border),
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                // 4 columns
                final itemWidth = (constraints.maxWidth - 36) / 4 - 0.1;
                return Wrap(
                  spacing: 12,
                  runSpacing: 16,
                  children: _sizeControllers.entries.map((entry) {
                    final size = entry.key;
                    final target = widget.targets[size] ?? 0;
                    return SizedBox(
                      width: itemWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Sisa: $target',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.muted,
                              fontSize: 11,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          KonveksioSizeInput(
                            sizeLabel: size,
                            controller: entry.value,
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
          
          const SizedBox(height: 16),
          
          if (state.error != null) ...[
            Text(
              state.error!.replaceAll('Exception: ', ''),
              style: const TextStyle(color: AppTheme.destructive),
            ),
            const SizedBox(height: 16),
          ],
          
          KonveksioButton(
            text: 'SIMPAN PROGRES',
            onPressed: state.isLoading ? null : _submit,
            isLoading: state.isLoading,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
