import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/konveksio_button.dart';
import '../../../../core/widgets/konveksio_text_field.dart';
import '../../../master/presentation/providers/customer_provider.dart';
import '../../../master/presentation/providers/product_provider.dart';
import '../../../production/presentation/providers/order_provider.dart';

class BossOrderFormScreen extends ConsumerStatefulWidget {
  const BossOrderFormScreen({super.key});

  @override
  ConsumerState<BossOrderFormScreen> createState() => _BossOrderFormScreenState();
}

class _BossOrderFormScreenState extends ConsumerState<BossOrderFormScreen> {
  String? _selectedCustomerId;
  final _deadlineController = TextEditingController();
  final _notesController = TextEditingController();
  
  String? _selectedProductId;
  final _priceController = TextEditingController();
  final Map<String, TextEditingController> _sizeControllers = {
    'S': TextEditingController(),
    'M': TextEditingController(),
    'L': TextEditingController(),
    'XL': TextEditingController(),
  };

  @override
  void dispose() {
    _deadlineController.dispose();
    _notesController.dispose();
    _priceController.dispose();
    for (var controller in _sizeControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _submit() async {
    if (_selectedCustomerId == null || _selectedProductId == null || _deadlineController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Harap lengkapi form')));
      return;
    }

    final priceText = _priceController.text.replaceAll('.', '');
    final price = double.tryParse(priceText) ?? 0;
    
    Map<String, int> sizes = {};
    int totalQty = 0;
    
    _sizeControllers.forEach((size, controller) {
      final qty = int.tryParse(controller.text) ?? 0;
      if (qty > 0) {
        sizes[size] = qty;
        totalQty += qty;
      }
    });
    
    if (totalQty == 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Minimal 1 item ukuran harus diisi')));
      return;
    }

    // Format deadline assuming dd-mm-yyyy input
    // To simplify for this demo, we'll parse it or just send a dummy date if format fails
    DateTime deadline;
    try {
      final parts = _deadlineController.text.split('-');
      deadline = DateTime(int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
    } catch (e) {
      deadline = DateTime.now().add(const Duration(days: 7));
    }

    final payload = {
      "p_customer_id": _selectedCustomerId,
      "p_deadline": deadline.toIso8601String(),
      "p_notes": _notesController.text,
      "p_items": [
        {
          "product_id": _selectedProductId,
          "quantity": totalQty,
          "price": price,
          "sizes": sizes
        }
      ]
    };

    await ref.read(orderListProvider.notifier).createOrder(payload);
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Order berhasil dibuat')));
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final customersAsync = ref.watch(customerListProvider);
    final productsAsync = ref.watch(productListProvider);

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
            customersAsync.when(
              data: (customers) {
                return DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Pilih Customer',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  value: _selectedCustomerId,
                  items: customers.map((c) => DropdownMenuItem(value: c.id, child: Text(c.name))).toList(),
                  onChanged: (v) => setState(() => _selectedCustomerId = v),
                  hint: const Text('Cari customer...'),
                );
              },
              loading: () => const CircularProgressIndicator(),
              error: (err, stack) => Text('Error: $err'),
            ),
            const SizedBox(height: AppTheme.spacingBase),
            
            const Text('Detail Order', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: AppTheme.spacingSm),
            KonveksioTextField(
              controller: _deadlineController,
              label: 'Batas Waktu (Deadline)',
              hintText: 'dd-mm-yyyy',
              prefixIcon: const Icon(PhosphorIconsRegular.calendar),
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
                  productsAsync.when(
                    data: (products) {
                      return DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                        value: _selectedProductId,
                        items: products.map((p) => DropdownMenuItem(value: p.id, child: Text(p.name))).toList(),
                        onChanged: (v) {
                          setState(() {
                            _selectedProductId = v;
                            final product = products.firstWhere((p) => p.id == v);
                            _priceController.text = NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0).format(product.priceMin).trim();
                          });
                        },
                        hint: const Text('Pilih produk...'),
                      );
                    },
                    loading: () => const CircularProgressIndicator(),
                    error: (err, stack) => Text('Error: $err'),
                  ),
                  const SizedBox(height: 16),
                  KonveksioTextField(
                    controller: _priceController,
                    label: 'Harga Final per Pcs (Rp)',
                    hintText: 'Contoh: 100.000',
                    keyboardType: TextInputType.number,
                    prefixIcon: const Icon(PhosphorIconsRegular.money),
                  ),
                  const SizedBox(height: 16),
                  const Text('Rincian Kuantitas (Size Group)', style: TextStyle(color: AppTheme.muted, fontSize: 13)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(child: KonveksioTextField(controller: _sizeControllers['S'], label: 'S', hintText: '0', keyboardType: TextInputType.number)),
                      const SizedBox(width: 8),
                      Expanded(child: KonveksioTextField(controller: _sizeControllers['M'], label: 'M', hintText: '0', keyboardType: TextInputType.number)),
                      const SizedBox(width: 8),
                      Expanded(child: KonveksioTextField(controller: _sizeControllers['L'], label: 'L', hintText: '0', keyboardType: TextInputType.number)),
                      const SizedBox(width: 8),
                      Expanded(child: KonveksioTextField(controller: _sizeControllers['XL'], label: 'XL', hintText: '0', keyboardType: TextInputType.number)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(AppTheme.spacingBase),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          border: const Border(top: BorderSide(color: AppTheme.border)),
        ),
        child: KonveksioButton(
          text: 'Simpan Order Baru',
          onPressed: _submit,
        ),
      ),
    );
  }
}
