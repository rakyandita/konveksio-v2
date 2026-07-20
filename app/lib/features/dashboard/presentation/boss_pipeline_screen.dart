import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import '../../../core/theme/app_theme.dart';
import '../../production/presentation/providers/task_provider.dart';
import '../../production/domain/task_model.dart';

class BossPipelineScreen extends ConsumerStatefulWidget {
  const BossPipelineScreen({super.key});

  @override
  ConsumerState<BossPipelineScreen> createState() => _BossPipelineScreenState();
}

class _BossPipelineScreenState extends ConsumerState<BossPipelineScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _divisions = ['Potong', 'Jahit', 'Sablon', 'Bordir', 'Finishing'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _divisions.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tasksAsync = ref.watch(taskListProvider);

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Pipeline Produksi'),
        backgroundColor: AppTheme.surface,
        scrolledUnderElevation: 4.0,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: AppTheme.primary,
          unselectedLabelColor: AppTheme.muted,
          indicatorColor: AppTheme.primary,
          tabAlignment: TabAlignment.start,
          tabs: _divisions.map((div) => Tab(text: div)).toList(),
        ),
      ),
      body: tasksAsync.when(
        data: (tasks) {
          return TabBarView(
            controller: _tabController,
            children: _divisions.map((div) {
              final divisionTasks = tasks.where((t) => t.division == div).toList();
              return _buildKanbanList(divisionTasks);
            }).toList(),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err', style: const TextStyle(color: AppTheme.destructive))),
      ),
    );
  }

  Widget _buildKanbanList(List<TaskModel> items) {
    if (items.isEmpty) {
      return const Center(
        child: Text('Tidak ada task aktif', style: TextStyle(color: AppTheme.muted)),
      );
    }
    return RefreshIndicator(
      onRefresh: () async => ref.invalidate(taskListProvider),
      child: ListView.builder(
        padding: const EdgeInsets.all(AppTheme.spacingBase),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final data = items[index];
          return _PipelineTaskCard(task: data);
        },
      ),
    );
  }
}

class _PipelineTaskCard extends ConsumerWidget {
  final TaskModel task;
  const _PipelineTaskCard({required this.task});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progressAsync = ref.watch(taskProgressProvider(task.id));
    
    return Card(
      elevation: 0,
      color: AppTheme.surface,
      margin: const EdgeInsets.only(bottom: AppTheme.spacingBase),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        side: const BorderSide(color: AppTheme.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingBase),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  task.id.split('-').first,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Icon(
                  task.status == 'completed' ? PhosphorIconsRegular.checkCircle : PhosphorIconsRegular.clock,
                  color: task.status == 'completed' ? AppTheme.success : AppTheme.warning,
                  size: 20,
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacingSm),
            Text(
              'Item: ${task.orderItemId.split('-').first}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppTheme.muted),
            ),
            const SizedBox(height: AppTheme.spacingBase),
            progressAsync.when(
              data: (progData) {
                final progress = progData['completed'] ?? 0;
                final target = progData['target'] ?? 1;
                final progressValue = progress / target;
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Progres',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          '$progress / $target pcs',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppTheme.primary,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: progressValue,
                      backgroundColor: AppTheme.border,
                      color: task.status == 'completed' ? AppTheme.success : AppTheme.primary,
                    ),
                  ],
                );
              },
              loading: () => const LinearProgressIndicator(color: AppTheme.primary),
              error: (err, _) => Text('Error: $err'),
            ),
          ],
        ),
      ),
    );
  }
}
