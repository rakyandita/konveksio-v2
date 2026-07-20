import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../auth/presentation/auth_controller.dart';

class HandoverState {
  final bool isLoading;
  final String? error;
  final bool isSuccess;

  const HandoverState({
    this.isLoading = false,
    this.error,
    this.isSuccess = false,
  });

  HandoverState copyWith({
    bool? isLoading,
    String? error,
    bool? isSuccess,
  }) {
    return HandoverState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

class HandoverController extends Notifier<HandoverState> {
  @override
  HandoverState build() {
    return const HandoverState();
  }

  Future<void> submitHandover({
    required String taskId,
    required String receiverId,
    required Map<String, int> sizes,
    String? notes,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final supabase = Supabase.instance.client;
      final authState = ref.read(authControllerProvider);
      
      if (!authState.isAuthenticated || authState.branchId == null || supabase.auth.currentUser == null) {
        throw Exception('Sesi tidak valid.');
      }

      // Insert handover
      final handoverRes = await supabase.from('handovers').insert({
        'from_task_id': taskId,
        'to_user_id': receiverId,
        'status': 'pending',
      }).select().single();
      
      final handoverId = handoverRes['id'];
      
      final sizeList = sizes.entries.map((e) => {
        'handover_id': handoverId,
        'size': e.key,
        'qty_sent': e.value,
      }).toList();
      
      await supabase.from('handover_sizes').insert(sizeList);
      
      state = state.copyWith(isLoading: false, isSuccess: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

final handoverControllerProvider = NotifierProvider<HandoverController, HandoverState>(() {
  return HandoverController();
});
