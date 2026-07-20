import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/konveksio_button.dart';
import 'boss_orders_controller.dart';
import '../../finance/presentation/forms/boss_payment_form_modal.dart' as import_payment;
import '../../finance/presentation/forms/boss_adjustment_form_modal.dart' as import_adj;

class BossOrderDetailScreen extends ConsumerWidget {
  final String orderId;

  const BossOrderDetailScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersAsync = ref.watch(bossOrdersControllerProvider);

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Detail Order'),
        backgroundColor: AppTheme.surface,
        scrolledUnderElevation: 4.0,
      ),
      body: ordersAsync.when(
        data: (orders) {
          final order = orders.firstWhere((o) => o.id == orderId, orElse: () => throw Exception('Order tidak ditemukan'));

          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppTheme.spacingBase),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildCustomerInfo(context, order),
                const SizedBox(height: AppTheme.spacingBase),
                _buildItemsList(context, order),
                const SizedBox(height: AppTheme.spacingBase),
                _buildPaymentHistory(context, order),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Text('Error: $err', style: const TextStyle(color: AppTheme.destructive)),
        ),
      ),
    );
  }

  Widget _buildCustomerInfo(BuildContext context, Order order) {
    final dateFormat = DateFormat('dd MMM yyyy');
    
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingBase),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(color: AppTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                order.id,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppTheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.background,
                  borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                  border: Border.all(color: AppTheme.border),
                ),
                child: Text(
                  order.status.toUpperCase(),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingSm),
          Text(
            order.customerName,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: AppTheme.spacingSm),
          Row(
            children: [
              const Icon(PhosphorIconsRegular.calendarBlank, size: 16, color: AppTheme.muted),
              const SizedBox(width: 4),
              Text(
                'Deadline: ${dateFormat.format(order.deadlineDate)}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.muted,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildItemsList(BuildContext context, Order order) {
    final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingBase),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(color: AppTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Item Pesanan',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: AppTheme.spacingBase),
          ...order.items.map((item) {
            final subtotal = item.pricePerPcs * item.totalQty;
            return Container(
              margin: const EdgeInsets.only(bottom: AppTheme.spacingSm),
              padding: const EdgeInsets.all(AppTheme.spacingSm),
              decoration: BoxDecoration(
                color: AppTheme.background,
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                border: Border.all(color: AppTheme.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.productName,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        currencyFormat.format(subtotal),
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${item.totalQty} pcs x ${currencyFormat.format(item.pricePerPcs)}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppTheme.muted),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => context.push('/boss/spk/${item.id}'),
                          icon: const Icon(PhosphorIconsRegular.fileText, size: 16),
                          label: const Text('SPK DIGITAL'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => context.push('/boss/assign'),
                          icon: const Icon(PhosphorIconsRegular.users, size: 16),
                          label: const Text('ASSIGN TUGAS'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildPaymentHistory(BuildContext context, Order order) {
    final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingBase),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(color: AppTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Keuangan Order',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                'Total: ${currencyFormat.format(order.totalPrice)}',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppTheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingBase),
          Center(
            child: Text(
              'Riwayat Pembayaran (Mockup Segera Hadir)',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppTheme.muted),
            ),
          ),
          const SizedBox(height: AppTheme.spacingBase),
          KonveksioButton(
            text: 'TAMBAH PEMBAYARAN',
            onPressed: () {
              import_payment.BossPaymentFormModal.show(context);
            },
          ),
          const SizedBox(height: AppTheme.spacingSm),
          KonveksioButton(
            text: 'TAMBAH PENYESUAIAN (DISKON / BIAYA)',
            onPressed: () {
              import_adj.BossAdjustmentFormModal.show(context);
            },
            type: KonveksioButtonType.secondary,
          ),
        ],
      ),
    );
  }
}
