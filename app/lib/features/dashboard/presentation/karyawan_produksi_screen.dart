import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class KaryawanProduksiScreen extends StatefulWidget {
  const KaryawanProduksiScreen({super.key});

  @override
  State<KaryawanProduksiScreen> createState() => _KaryawanProduksiScreenState();
}

class _KaryawanProduksiScreenState extends State<KaryawanProduksiScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
            Tab(text: 'MASUK (1)'),
            Tab(text: 'PROSES (2)'),
            Tab(text: 'SELESAI'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildMasukTab(),
          _buildProsesTab(),
          _buildSelesaiTab(),
        ],
      ),
    );
  }

  Widget _buildMasukTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 1,
      itemBuilder: (context, index) {
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
                    const Icon(Icons.inventory_2_outlined, color: AppTheme.primary),
                    const SizedBox(width: 8),
                    Text(
                      'Dari: Budi (Divisi Potong)',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text('Order: Kemeja Polos Merah', style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: 4),
                Text('Qty: 50 pcs', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.muted)),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppTheme.destructive,
                          side: const BorderSide(color: AppTheme.destructive),
                        ),
                        child: const Text('Tolak'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('TERIMA BARANG'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProsesTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 2,
      itemBuilder: (context, index) {
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
                    const Icon(Icons.content_cut, color: AppTheme.primary),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        index == 0 ? 'Jahit - Kaos Oblong V-Neck' : 'Sablon - Jaket Bomber',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  index == 0 ? 'Progres: 20 / 100 pcs selesai' : 'Progres: 0 / 50 pcs selesai',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.muted),
                ),
                const SizedBox(height: 16),
                LinearProgressIndicator(
                  value: index == 0 ? 0.2 : 0,
                  backgroundColor: AppTheme.border,
                  color: AppTheme.primary,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('UPDATE PROGRES'),
                ),
              ],
            ),
          ),
        );
      },
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
            leading: const Icon(Icons.check_circle, color: AppTheme.success),
            title: Text('Celana Training SMP - ${index + 1}'),
            subtitle: const Text('50 pcs selesai hari ini'),
          ),
        );
      },
    );
  }
}
