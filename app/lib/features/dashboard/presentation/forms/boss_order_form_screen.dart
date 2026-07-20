import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/konveksio_button.dart';
import '../../../../core/widgets/konveksio_text_field.dart';

class BossOrderFormScreen extends StatefulWidget {
  const BossOrderFormScreen({super.key});

  @override
  State<BossOrderFormScreen> createState() => _BossOrderFormScreenState();
}

class _BossOrderFormScreenState extends State<BossOrderFormScreen> {
  final _customerController = TextEditingController();
  final _deadlineController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _customerController.dispose();
    _deadlineController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Buat Order Baru'),
        backgroundColor: AppTheme.surface,
        leading: IconButton(
          icon: const Icon(PhosphorIconsRegular.x),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingBase),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Informasi Pemesan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: AppTheme.spacingSm),
            KonveksioTextField(
              controller: _customerController,
              label: 'Pilih Customer',
              hintText: 'Cari customer...',
              prefixIcon: Icon(PhosphorIconsRegular.user),
            ),
            const SizedBox(height: AppTheme.spacingBase),
            
            const Text('Detail Order', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: AppTheme.spacingSm),
            KonveksioTextField(
              controller: _deadlineController,
              label: 'Batas Waktu (Deadline)',
              hintText: 'dd-mm-yyyy',
              prefixIcon: Icon(PhosphorIconsRegular.calendar),
            ),
            const SizedBox(height: AppTheme.spacingSm),
            KonveksioTextField(
              controller: _notesController,
              label: 'Catatan Order',
              hintText: 'Masukkan catatan tambahan...',
              maxLines: 3,
            ),
            const SizedBox(height: AppTheme.spacingLg),
            
            const Text('Item Produk', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: AppTheme.spacingSm),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                border: Border.all(color: AppTheme.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Pilih Produk (Katalog)', style: TextStyle(color: AppTheme.muted, fontSize: 13)),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    items: const [
                      DropdownMenuItem(value: '1', child: Text('Kaos Polo Standard')),
                      DropdownMenuItem(value: '2', child: Text('Kemeja PDL')),
                    ],
                    onChanged: (v) {},
                    hint: const Text('Pilih produk...'),
                  ),
                  const SizedBox(height: 16),
                  const Text('Harga Final per Pcs (Rp)', style: TextStyle(color: AppTheme.muted, fontSize: 13)),
                  const SizedBox(height: 8),
                  KonveksioTextField(
                    hintText: 'Contoh: 100.000',
                    keyboardType: TextInputType.number,
                    prefixIcon: Icon(PhosphorIconsRegular.money),
                  ),
                  const SizedBox(height: 16),
                  const Text('Rincian Kuantitas (Size Group)', style: TextStyle(color: AppTheme.muted, fontSize: 13)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(child: KonveksioTextField(label: 'S', hintText: '0', keyboardType: TextInputType.number)),
                      const SizedBox(width: 8),
                      Expanded(child: KonveksioTextField(label: 'M', hintText: '0', keyboardType: TextInputType.number)),
                      const SizedBox(width: 8),
                      Expanded(child: KonveksioTextField(label: 'L', hintText: '0', keyboardType: TextInputType.number)),
                      const SizedBox(width: 8),
                      Expanded(child: KonveksioTextField(label: 'XL', hintText: '0', keyboardType: TextInputType.number)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.spacingSm),
            Center(
              child: TextButton.icon(
                onPressed: () {},
                icon: const Icon(PhosphorIconsRegular.plus, size: 18),
                label: const Text('Tambah Item Produk'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(AppTheme.spacingBase),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          border: Border(top: BorderSide(color: AppTheme.border)),
        ),
        child: KonveksioButton(
          text: 'Simpan Order Baru',
          onPressed: () {
            context.pop();
          },
        ),
      ),
    );
  }
}
