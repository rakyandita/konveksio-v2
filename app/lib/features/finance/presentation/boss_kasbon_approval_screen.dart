import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/konveksio_button.dart';
import '../../../core/widgets/konveksio_card.dart';
import 'boss_kasbon_approval_controller.dart';
import '../domain/cash_advance.dart';

class BossKasbonApprovalScreen extends ConsumerWidget {
  const BossKasbonApprovalScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(bossKasbonApprovalControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Approval Kasbon'),
        leading: IconButton(
          icon: const Icon(PhosphorIconsRegular.arrowLeft),
          onPressed: () => context.pop(),
        ),
      ),
      body: state.isLoading && state.pendingRequests.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : state.error != null
              ? Center(child: Text('Error: ${state.error}'))
              : state.pendingRequests.isEmpty
                  ? const Center(child: Text('Tidak ada pengajuan kasbon tertunda'))
                  : ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: state.pendingRequests.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final request = state.pendingRequests[index];
                        return _KasbonCard(request: request);
                      },
                    ),
    );
  }
}

class _KasbonCard extends ConsumerWidget {
  final CashAdvance request;

  const _KasbonCard({required this.request});

  void _showRejectDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tolak Pengajuan'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Berikan alasan penolakan (opsional):'),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Contoh: Belum ada progres minggu ini',
                border: const OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.destructive, foregroundColor: Colors.white),
            onPressed: () {
              ref.read(bossKasbonApprovalControllerProvider.notifier).rejectRequest(request.id, controller.text);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Pengajuan kasbon berhasil ditolak'),
                  backgroundColor: AppTheme.destructive,
                ),
              );
            },
            child: const Text('TOLAK KASBON'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return KonveksioCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                request.userId,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.warning.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Menunggu',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.warning,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nominal', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppTheme.muted)),
                  const SizedBox(height: 4),
                  Text(
                    AppFormatters.formatCurrency(request.amountRequested),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppTheme.destructive,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Keperluan', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppTheme.muted)),
                  const SizedBox(height: 4),
                  Text(
                    request.reason,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: KonveksioButton(
                  text: 'TOLAK',
                  type: KonveksioButtonType.secondary,
                  onPressed: () => _showRejectDialog(context, ref),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: KonveksioButton(
                  text: 'SETUJUI',
                  type: KonveksioButtonType.primary,
                  onPressed: () {
                    ref.read(bossKasbonApprovalControllerProvider.notifier).approveRequest(request.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Pengajuan kasbon berhasil disetujui'),
                        backgroundColor: AppTheme.success,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
