import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/konveksio_button.dart';
import '../../../core/widgets/konveksio_text_field.dart';

class BossSpkScreen extends ConsumerStatefulWidget {
  final String orderItemId;

  const BossSpkScreen({super.key, required this.orderItemId});

  @override
  ConsumerState<BossSpkScreen> createState() => _BossSpkScreenState();
}

class _BossSpkScreenState extends ConsumerState<BossSpkScreen> {
  final _clientNameController = TextEditingController(text: 'Dinas Pendidikan');
  final _materialController = TextEditingController(text: 'Drill (Kain Keras)');
  final _colorController = TextEditingController(text: 'Khaki');
  final _styleController = TextEditingController(text: 'Lengan Pendek, Pundak Epaulette');

  @override
  void dispose() {
    _clientNameController.dispose();
    _materialController.dispose();
    _colorController.dispose();
    _styleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Edit SPK Digital'),
        backgroundColor: AppTheme.surface,
        scrolledUnderElevation: 4.0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingBase),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
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
                    'Informasi SPK',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: AppTheme.spacingBase),
                  KonveksioTextField(
                    label: 'Nama Klien (Opsional di SPK)',
                    controller: _clientNameController,
                  ),
                  const SizedBox(height: AppTheme.spacingSm),
                  KonveksioTextField(
                    label: 'Bahan Utama',
                    controller: _materialController,
                  ),
                  const SizedBox(height: AppTheme.spacingSm),
                  KonveksioTextField(
                    label: 'Warna',
                    controller: _colorController,
                  ),
                  const SizedBox(height: AppTheme.spacingSm),
                  KonveksioTextField(
                    label: 'Gaya / Potongan',
                    controller: _styleController,
                    maxLines: 3,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.spacingBase),
            Container(
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
                    'Desain & Gambar',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: AppTheme.spacingBase),
                  Row(
                    children: [
                      Expanded(
                        child: _buildImageUploadArea(context, 'Tampak Depan'),
                      ),
                      const SizedBox(width: AppTheme.spacingSm),
                      Expanded(
                        child: _buildImageUploadArea(context, 'Tampak Belakang'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.spacingBase),
            KonveksioButton(
              text: 'SIMPAN SPK',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('SPK berhasil disimpan (Mock)')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageUploadArea(BuildContext context, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Container(
          height: 120,
          decoration: BoxDecoration(
            color: AppTheme.background,
            borderRadius: BorderRadius.circular(AppTheme.radiusMd),
            border: Border.all(color: AppTheme.border, style: BorderStyle.solid),
          ),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(PhosphorIconsRegular.image, color: AppTheme.muted, size: 32),
                SizedBox(height: 8),
                Text('Tap to Upload', style: TextStyle(color: AppTheme.muted, fontSize: 12)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
