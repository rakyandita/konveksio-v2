import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/task_model.dart';
import '../../data/task_repository.dart';
import '../../domain/handover_model.dart';

final taskListProvider = AsyncNotifierProvider<TaskListNotifier, List<TaskModel>>(() {
  return TaskListNotifier();
});

class TaskListNotifier extends AsyncNotifier<List<TaskModel>> {
  @override
  Future<List<TaskModel>> build() async {
    return ref.watch(taskRepositoryProvider).getTasks();
  }
}

final userTaskListProvider = FutureProvider.family<List<TaskModel>, String>((ref, userId) async {
  return ref.watch(taskRepositoryProvider).getTasksByUser(userId);
});

final incomingHandoverProvider = FutureProvider.family<List<HandoverModel>, String>((ref, userId) async {
  return ref.watch(taskRepositoryProvider).getIncomingHandovers(userId);
});
