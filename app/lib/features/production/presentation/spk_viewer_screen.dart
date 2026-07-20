import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import 'spk_viewer_controller.dart';

class SpkViewerScreen extends ConsumerWidget {
  final String orderItemId;

  const SpkViewerScreen({
    super.key,
    required this.orderItemId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final spkAsync = ref.watch(spkViewerControllerProvider(orderItemId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail SPK'),
        backgroundColor: AppTheme.surface,
        foregroundColor: AppTheme.foreground,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: AppTheme.background,
      body: spkAsync.when(
        data: (spk) {
          if (spk == null) {
            return const Center(
              child: Text(
                'SPK belum dibuat untuk pesanan ini.',
                style: TextStyle(color: AppTheme.muted),
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeaderInfo(context, spk),
                const SizedBox(height: 16),
                _buildSpecCard(context, spk),
                const SizedBox(height: 16),
                _buildImageSection(context, 'Desain Tampak Depan', spk.frontImageUrl),
                const SizedBox(height: 16),
                _buildImageSection(context, 'Desain Tampak Belakang', spk.backImageUrl),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text(
            'Terjadi kesalahan: $error',
            style: const TextStyle(color: AppTheme.destructive),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderInfo(BuildContext context, Spk spk) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(color: AppTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order:',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppTheme.muted),
          ),
          Text(
            spk.orderName ?? 'Pesanan',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Instansi / Klien:',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppTheme.muted),
          ),
          Text(
            spk.clientName ?? '-',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildSpecCard(BuildContext context, Spk spk) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(color: AppTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Spesifikasi Produksi',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const Divider(height: 24),
          _buildSpecRow(context, 'Produk', spk.productName ?? '-'),
          const SizedBox(height: 12),
          _buildSpecRow(context, 'Bahan', spk.material ?? '-'),
          const SizedBox(height: 12),
          _buildSpecRow(context, 'Warna', spk.color ?? '-'),
          const SizedBox(height: 12),
          _buildSpecRow(context, 'Model/Catatan', spk.style ?? '-'),
        ],
      ),
    );
  }

  Widget _buildSpecRow(BuildContext context, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: const TextStyle(color: AppTheme.muted),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  Widget _buildImageSection(BuildContext context, String title, String? imageUrl) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(color: AppTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          if (imageUrl != null && imageUrl.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              child: Image.network(
                imageUrl,
                width: double.infinity,
                fit: BoxFit.contain,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    height: 200,
                    color: AppTheme.background,
                    child: const Center(child: CircularProgressIndicator()),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    color: AppTheme.background,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.broken_image, size: 48, color: AppTheme.muted),
                        SizedBox(height: 8),
                        Text('Gambar gagal dimuat', style: TextStyle(color: AppTheme.muted)),
                      ],
                    ),
                  );
                },
              ),
            )
          else
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                color: AppTheme.background,
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                border: Border.all(color: AppTheme.border, style: BorderStyle.solid),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.image_not_supported, size: 48, color: AppTheme.muted),
                  SizedBox(height: 8),
                  Text('Tidak ada gambar desain', style: TextStyle(color: AppTheme.muted)),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
