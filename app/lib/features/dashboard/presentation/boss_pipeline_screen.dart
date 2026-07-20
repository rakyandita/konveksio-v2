import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import '../../../core/theme/app_theme.dart';

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
      body: TabBarView(
        controller: _tabController,
        children: _divisions.map((div) => _buildKanbanList(div)).toList(),
      ),
    );
  }

  Widget _buildKanbanList(String division) {
    // Data mock
    final items = [
      {'order': 'ORD-001', 'item': 'Kemeja PDL', 'progress': 30, 'target': 50, 'status': 'running'},
      {'order': 'ORD-002', 'item': 'Kaos Polo', 'progress': 100, 'target': 100, 'status': 'completed'},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(AppTheme.spacingBase),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final data = items[index];
        final progress = data['progress'] as int;
        final target = data['target'] as int;
        final progressValue = progress / target;

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
                      '${data['order']} - ${data['item']}',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Icon(
                      data['status'] == 'completed' ? PhosphorIconsRegular.checkCircle : PhosphorIconsRegular.clock,
                      color: data['status'] == 'completed' ? AppTheme.success : AppTheme.warning,
                      size: 20,
                    ),
                  ],
                ),
                const SizedBox(height: AppTheme.spacingSm),
                Text(
                  'Dikerjakan oleh: Budi (Karyawan)',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppTheme.muted),
                ),
                const SizedBox(height: AppTheme.spacingBase),
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
                  color: data['status'] == 'completed' ? AppTheme.success : AppTheme.primary,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
