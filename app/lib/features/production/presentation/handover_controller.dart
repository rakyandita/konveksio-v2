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
    required int quantity,
    String? notes,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final supabase = Supabase.instance.client;
      final authState = ref.read(authControllerProvider);
      
      if (!authState.isAuthenticated || authState.branchId == null || supabase.auth.currentUser == null) {
        throw Exception('Sesi tidak valid.');
      }

      await supabase.from('handovers').insert({
        'task_id': taskId,
        'sender_id': supabase.auth.currentUser!.id,
        'receiver_id': receiverId,
        'quantity': quantity,
        'notes': notes,
        'status': 'pending',
      });
      
      state = state.copyWith(isLoading: false, isSuccess: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

final handoverControllerProvider = NotifierProvider<HandoverController, HandoverState>(() {
  return HandoverController();
});
