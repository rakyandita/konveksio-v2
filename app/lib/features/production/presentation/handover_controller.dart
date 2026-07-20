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

      // Call RPC
      final sizesPayload = sizes.entries.map((e) => {
        'size': e.key,
        'qty': e.value,
      }).toList();

      await supabase.rpc('submit_handover', params: {
        'payload': {
          'p_from_task_id': taskId,
          'p_to_user_id': receiverId.startsWith('user_') ? null : receiverId, // Adjust logic as needed
          'p_to_vendor_id': receiverId == 'user_vendor' ? receiverId : null,
          'p_sizes': sizesPayload,
        }
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
