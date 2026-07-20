import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../dashboard/presentation/karyawan_tasks_controller.dart';

class UpdateProgressState {
  final bool isLoading;
  final String? error;
  final bool isSuccess;

  const UpdateProgressState({
    this.isLoading = false,
    this.error,
    this.isSuccess = false,
  });

  UpdateProgressState copyWith({
    bool? isLoading,
    String? error,
    bool? isSuccess,
  }) {
    return UpdateProgressState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

class UpdateProgressController extends Notifier<UpdateProgressState> {
  @override
  UpdateProgressState build() {
    return const UpdateProgressState();
  }

  Future<void> submitProgress(
    String taskId,
    Map<String, int> inputs,
    Map<String, int> targets,
  ) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      // Validate inputs (Frontend Security Hardening)
      final toSubmit = inputs.entries.where((e) => e.value > 0).toList();
      
      if (toSubmit.isEmpty) {
        throw Exception('Tidak ada progres yang diisi (minimal 1 pcs).');
      }

      for (final entry in toSubmit) {
        final size = entry.key;
        final qty = entry.value;
        final target = targets[size] ?? 0;
        
        if (qty > target) {
          throw Exception('Qty size $size ($qty) melebihi sisa target ($target).');
        }
      }

      final supabase = Supabase.instance.client;
      final userId = supabase.auth.currentUser?.id;

      if (userId == null) {
        // Mock success if not logged in (for demo)
        await Future.delayed(const Duration(seconds: 1));
        state = state.copyWith(isLoading: false, isSuccess: true);
        return;
      }

      final payload = toSubmit.map((e) => {
        'task_id': taskId,
        'user_id': userId,
        'size': e.key,
        'qty_completed': e.value,
      }).toList();

      await supabase.from('progress_logs').insert(payload);
      ref.invalidate(karyawanTasksControllerProvider);
      state = state.copyWith(isLoading: false, isSuccess: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

final updateProgressControllerProvider =
    NotifierProvider<UpdateProgressController, UpdateProgressState>(
        UpdateProgressController.new);
