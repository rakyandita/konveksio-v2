import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/supabase/supabase_client_provider.dart';
import '../domain/task_model.dart';
import '../domain/handover_model.dart';
import '../domain/progress_log_model.dart';

final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  return TaskRepository(ref.watch(supabaseClientProvider));
});

class TaskRepository {
  final SupabaseClient _supabase;

  TaskRepository(this._supabase);

  Future<List<TaskModel>> getTasks() async {
    final response = await _supabase
        .from('tasks')
        .select();
    return response.map((json) => TaskModel.fromJson(json)).toList();
  }

  Future<List<TaskModel>> getTasksByUser(String userId) async {
    final response = await _supabase
        .from('tasks')
        .select()
        .eq('assigned_to_user', userId);
    return response.map((json) => TaskModel.fromJson(json)).toList();
  }

  Future<List<TaskSizeModel>> getTaskSizes(String taskId) async {
    final response = await _supabase
        .from('task_sizes')
        .select()
        .eq('task_id', taskId);
    return response.map((json) => TaskSizeModel.fromJson(json)).toList();
  }

  Future<void> bulkInsertTasks(List<Map<String, dynamic>> tasksPayload) async {
    await _supabase.rpc('bulk_insert_tasks', params: {'p_tasks': tasksPayload});
  }

  Future<void> submitHandover(Map<String, dynamic> payload) async {
    await _supabase.rpc('submit_handover', params: {'payload': payload});
  }

  Future<void> acceptHandover(String handoverId, List<Map<String, dynamic>> actualSizes) async {
    await _supabase.rpc('accept_handover', params: {
      'p_handover_id': handoverId,
      'p_actual_sizes': actualSizes
    });
  }

  Future<List<HandoverModel>> getIncomingHandovers(String userId) async {
    final response = await _supabase
        .from('handovers')
        .select()
        .eq('to_user_id', userId)
        .eq('status', 'pending');
    return response.map((json) => HandoverModel.fromJson(json)).toList();
  }

  Future<void> logProgress(String taskId, String size, int qty) async {
    final userId = _supabase.auth.currentUser!.id;
    await _supabase.from('progress_logs').insert({
      'task_id': taskId,
      'user_id': userId,
      'size': size,
      'qty_completed': qty
    });
  }
}
