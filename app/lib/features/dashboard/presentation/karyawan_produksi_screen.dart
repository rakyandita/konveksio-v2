import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/konveksio_button.dart';
import '../../production/presentation/handover_modal.dart';
import '../../production/presentation/update_progress_modal.dart';
import '../../production/presentation/karyawan_selesai_detail_modal.dart';
import 'karyawan_tasks_controller.dart';
import 'karyawan_incoming_tasks_controller.dart';
class KaryawanProduksiScreen extends ConsumerStatefulWidget {
  const KaryawanProduksiScreen({super.key});

  @override
  ConsumerState<KaryawanProduksiScreen> createState() => _KaryawanProduksiScreenState();
}

class _KaryawanProduksiScreenState extends ConsumerState<KaryawanProduksiScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    
    // Future expansion: we can listen to tab changes to fetch different lists
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showTerimaBarangDialog(BuildContext context, WidgetRef ref, IncomingTaskItem handover) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Terima Barang'),
        content: const Text('Apakah Anda yakin telah menerima barang dan qty sudah sesuai?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();
              try {
                await ref.read(karyawanIncomingTasksControllerProvider.notifier).acceptHandover(
                  handover.handoverId,
                  handover.handoverSizes,
                );
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Barang berhasil diterima dan tugas baru telah dibuat.')),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
                  );
                }
              }
            },
            child: const Text('Terima'),
          ),
        ],
      ),
    );
  }

  void _showTolakDialog(BuildContext context, WidgetRef ref, IncomingTaskItem handover) {
    final reasonController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tolak Barang'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Berikan alasan penolakan (opsional):'),
            const SizedBox(height: 8),
            TextField(
              controller: reasonController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Alasan penolakan',
              ),
              maxLines: 2,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.destructive, foregroundColor: Colors.white),
            onPressed: () async {
              Navigator.of(context).pop();
              try {
                await ref.read(karyawanIncomingTasksControllerProvider.notifier).rejectHandover(
                  handover.handoverId,
                  reasonController.text,
                );
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Barang berhasil ditolak.')),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
                  );
                }
              }
            },
            child: const Text('Tolak'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produksi'),
        backgroundColor: AppTheme.surface,
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppTheme.primary,
          unselectedLabelColor: AppTheme.muted,
          indicatorColor: AppTheme.primary,
          tabs: const [
            Tab(text: 'MASUK'),
            Tab(text: 'PROSES'),
            Tab(text: 'SELESAI'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildMasukTab(), // still mock for now
          _buildProsesTab(), // using real data
          _buildSelesaiTab(), // still mock
        ],
      ),
    );
  }

  Widget _buildMasukTab() {
    final incomingAsync = ref.watch(karyawanIncomingTasksControllerProvider);

    return incomingAsync.when(
      data: (handovers) {
        if (handovers.isEmpty) {
          return const Center(
            child: Text('Tidak ada barang masuk.', style: TextStyle(color: AppTheme.muted)),
          );
        }

        return RefreshIndicator(
          onRefresh: () async => ref.invalidate(karyawanIncomingTasksControllerProvider),
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: handovers.length,
            itemBuilder: (context, index) {
              final handover = handovers[index];

              return Card(
                elevation: 2,
                color: AppTheme.surface,
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: AppTheme.primary.withValues(alpha: 0.1),
                            child: Icon(PhosphorIconsRegular.package, color: AppTheme.primary),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Dari: ${handover.fromDivision}',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () {
                              context.push('/karyawan/spk/${handover.orderItemId}');
                            },
                            icon: const Icon(PhosphorIconsRegular.fileText, size: 16),
                            label: const Text('DETAIL SPK'),
                            style: TextButton.styleFrom(
                              foregroundColor: AppTheme.primary,
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(handover.productName, style: Theme.of(context).textTheme.bodyLarge),
                      if (handover.customerName != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          'Klien: ${handover.customerName}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppTheme.muted),
                        ),
                      ],
                      const SizedBox(height: 4),
                      Text('Total Qty: ${handover.totalQty} pcs', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.muted)),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: KonveksioButton(
                              text: 'Tolak',
                              type: KonveksioButtonType.destructive,
                              onPressed: () => _showTolakDialog(context, ref, handover),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            flex: 2,
                            child: KonveksioButton(
                              text: 'TERIMA BARANG',
                              onPressed: () => _showTerimaBarangDialog(context, ref, handover),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Text('Terjadi kesalahan: $error', style: const TextStyle(color: AppTheme.destructive)),
      ),
    );
  }

  Widget _buildProsesTab() {
    final tasksAsync = ref.watch(karyawanTasksControllerProvider);

    return tasksAsync.when(
      data: (tasks) {
        final runningTasks = tasks.where((t) => t.status == 'running').toList();
        
        if (runningTasks.isEmpty) {
          return const Center(
            child: Text('Tidak ada tugas aktif.', style: TextStyle(color: AppTheme.muted)),
          );
        }

        return RefreshIndicator(
          onRefresh: () async => ref.invalidate(karyawanTasksControllerProvider),
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: runningTasks.length,
            itemBuilder: (context, index) {
              final task = runningTasks[index];
              final totalTarget = task.totalTarget;
              final totalCompleted = task.totalCompleted;
              final progressValue = totalTarget > 0 ? (totalCompleted / totalTarget) : 0.0;

              return Card(
                elevation: 2,
                color: AppTheme.surface,
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: AppTheme.primary.withValues(alpha: 0.1),
                            child: Icon(PhosphorIconsRegular.scissors, color: AppTheme.primary),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              task.productName,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () {
                              context.push('/karyawan/spk/${task.orderItemId}');
                            },
                            icon: const Icon(PhosphorIconsRegular.fileText, size: 16),
                            label: const Text('DETAIL SPK'),
                            style: TextButton.styleFrom(
                              foregroundColor: AppTheme.primary,
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      if (task.customerName != null) ...[
                        Text(
                          'Klien: ${task.customerName}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppTheme.muted),
                        ),
                        const SizedBox(height: 4),
                      ],
                      Text(
                        'Progres: $totalCompleted / $totalTarget pcs selesai',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.muted),
                      ),
                      const SizedBox(height: 16),
                      LinearProgressIndicator(
                        value: progressValue.clamp(0.0, 1.0),
                        backgroundColor: AppTheme.border,
                        color: AppTheme.primary,
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                UpdateProgressModal.show(context, task.id, task.remainingTargets);
                              },
                              child: const Text('UPDATE PROGRES'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                HandoverModal.show(context, task.id, sizes: task.remainingTargets.keys.toList());
                              },
                              child: const Text('SERAH TERIMA'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Text('Terjadi kesalahan: $error', style: const TextStyle(color: AppTheme.destructive)),
      ),
    );
  }

  Widget _buildSelesaiTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: AppTheme.border),
          ),
          color: AppTheme.background,
          margin: const EdgeInsets.only(bottom: 16),
          child: ListTile(
            title: Text('SPK-202310-${250 + index}', style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: const Text('Selesai pada: 25 Okt 2023'),
            trailing: const Icon(PhosphorIconsRegular.checkCircle, color: AppTheme.success),
            onTap: () {
              KaryawanSelesaiDetailModal.show(context, taskName: 'SPK-202310-${250 + index}', date: '25 Okt 2023');
            },
          ),
        );
      },
    );
  }
}
