import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import '../../../core/theme/app_theme.dart';
import 'boss_orders_controller.dart';

class BossOrdersScreen extends ConsumerStatefulWidget {
  const BossOrdersScreen({super.key});

  @override
  ConsumerState<BossOrdersScreen> createState() => _BossOrdersScreenState();
}

class _BossOrdersScreenState extends ConsumerState<BossOrdersScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  final List<String> _statuses = [
    'draft', 'confirmation', 'running', 'completed', 'shipped', 'done', 'cancelled'
  ];
  
  final List<String> _tabLabels = [
    'Draft', 'Konfirmasi', 'Produksi', 'Selesai', 'Dikirim', 'Done', 'Batal'
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _statuses.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ordersAsync = ref.watch(bossOrdersControllerProvider);

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Daftar Order'),
        backgroundColor: AppTheme.surface,
        scrolledUnderElevation: 4.0,
        actions: [
          IconButton(
            icon: const Icon(PhosphorIconsRegular.plus),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Form Tambah Order (Segera Hadir)')),
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: AppTheme.primary,
          unselectedLabelColor: AppTheme.muted,
          indicatorColor: AppTheme.primary,
          tabAlignment: TabAlignment.start,
          tabs: _tabLabels.map((label) => Tab(text: label)).toList(),
        ),
      ),
      body: ordersAsync.when(
        data: (orders) {
          return TabBarView(
            controller: _tabController,
            children: _statuses.map((status) {
              final filteredOrders = orders.where((o) => o.status == status).toList();
              
              if (filteredOrders.isEmpty) {
                return const Center(
                  child: Text('Tidak ada order di status ini', style: TextStyle(color: AppTheme.muted)),
                );
              }

              return RefreshIndicator(
                onRefresh: () async => ref.invalidate(bossOrdersControllerProvider),
                child: ListView.builder(
                  padding: const EdgeInsets.all(AppTheme.spacingBase),
                  itemCount: filteredOrders.length,
                  itemBuilder: (context, index) {
                    final order = filteredOrders[index];
                    return _buildOrderCard(context, order);
                  },
                ),
              );
            }).toList(),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Text('Error: $err', style: const TextStyle(color: AppTheme.destructive)),
        ),
      ),
    );
  }

  Widget _buildOrderCard(BuildContext context, Order order) {
    final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    final dateFormat = DateFormat('dd MMM yyyy');
    
    // Hitung status deadline
    final daysToDeadline = order.deadlineDate.difference(DateTime.now()).inDays;
    Color deadlineColor = AppTheme.muted;
    if (order.status == 'running' || order.status == 'confirmation') {
      if (daysToDeadline < 3 && daysToDeadline >= 0) {
        deadlineColor = AppTheme.warning;
      } else if (daysToDeadline < 0) {
        deadlineColor = AppTheme.destructive;
      }
    }

    return Card(
      elevation: 0,
      color: AppTheme.surface,
      margin: const EdgeInsets.only(bottom: AppTheme.spacingBase),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        side: const BorderSide(color: AppTheme.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push('/boss/orders/${order.id}'),
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacingBase),
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
                      '${order.items.length} item',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.spacingSm),
              Text(
                order.customerName,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: AppTheme.spacingSm),
              Row(
                children: [
                  Icon(PhosphorIconsRegular.calendarBlank, size: 16, color: deadlineColor),
                  const SizedBox(width: 4),
                  Text(
                    'Deadline: ${dateFormat.format(order.deadlineDate)}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: deadlineColor,
                          fontWeight: deadlineColor != AppTheme.muted ? FontWeight.bold : FontWeight.normal,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.spacingSm),
              Row(
                children: [
                  const Icon(PhosphorIconsRegular.money, size: 16, color: AppTheme.muted),
                  const SizedBox(width: 4),
                  Text(
                    currencyFormat.format(order.totalPrice),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppTheme.muted),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
