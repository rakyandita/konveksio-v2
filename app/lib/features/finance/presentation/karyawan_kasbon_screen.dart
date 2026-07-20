import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/konveksio_button.dart';
import 'karyawan_kasbon_controller.dart';

class KaryawanKasbonScreen extends ConsumerStatefulWidget {
  const KaryawanKasbonScreen({super.key});

  @override
  ConsumerState<KaryawanKasbonScreen> createState() => _KaryawanKasbonScreenState();
}

class _KaryawanKasbonScreenState extends ConsumerState<KaryawanKasbonScreen> {
  final _amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  String? _selectedReason;
  
  final List<String> _reasons = [
    'Kebutuhan Harian',
    'Sekolah Anak',
    'Listrik/Air',
    'Kesehatan',
    'Lainnya',
  ];

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _submit(double limit) {
    if (!_formKey.currentState!.validate()) return;
    
    if (_selectedReason == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pilih alasan pengajuan kasbon'),
          backgroundColor: AppTheme.destructive,
        ),
      );
      return;
    }

    final rawText = _amountController.text.replaceAll(RegExp(r'[^0-9]'), '');
    final amount = double.tryParse(rawText) ?? 0.0;

    if (amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nominal harus lebih dari 0'),
          backgroundColor: AppTheme.destructive,
        ),
      );
      return;
    }

    if (amount > limit) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Nominal melebihi sisa limit Anda (Maks ${AppFormatters.formatCurrency(limit)})'),
          backgroundColor: AppTheme.destructive,
        ),
      );
      return;
    }

    ref.read(karyawanKasbonControllerProvider.notifier).submitKasbon(
      amount: amount,
      reason: _selectedReason!,
    );
  }

  @override
  Widget build(BuildContext context) {
    final limitAsync = ref.watch(kasbonLimitProvider);
    final state = ref.watch(karyawanKasbonControllerProvider);

    ref.listen(karyawanKasbonControllerProvider, (previous, next) {
      if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error!),
            backgroundColor: AppTheme.destructive,
          ),
        );
      }
      if (next.isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Pengajuan kasbon berhasil dikirim'),
            backgroundColor: AppTheme.success,
          ),
        );
        context.pop();
      }
    });

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Pengajuan Kasbon'),
        backgroundColor: AppTheme.surface,
        scrolledUnderElevation: 4.0,
        shadowColor: const Color(0x26000000),
      ),
      body: limitAsync.when(
        data: (limit) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppTheme.spacingBase),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildLimitCard(limit),
                  const SizedBox(height: AppTheme.spacingLg),
                  
                  Text(
                    'Nominal Pengajuan',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingSm),
                  TextFormField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppTheme.primary,
                    ),
                    decoration: InputDecoration(
                      prefixText: 'Rp ',
                      prefixStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppTheme.primary,
                      ),
                      filled: true,
                      fillColor: AppTheme.surface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.all(AppTheme.spacingLg),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      _CurrencyInputFormatter(),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nominal tidak boleh kosong';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      // Trigger rebuild to update button state
                      setState(() {});
                    },
                  ),
                  const SizedBox(height: AppTheme.spacingLg),

                  Text(
                    'Alasan Pengajuan',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingSm),
                  Wrap(
                    spacing: AppTheme.spacingSm,
                    runSpacing: AppTheme.spacingSm,
                    children: _reasons.map((reason) {
                      final isSelected = _selectedReason == reason;
                      return ChoiceChip(
                        label: Text(reason),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            _selectedReason = selected ? reason : null;
                          });
                        },
                        selectedColor: AppTheme.primary,
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : AppTheme.foreground,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        ),
                        backgroundColor: AppTheme.surface,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                          side: BorderSide(
                            color: isSelected ? AppTheme.primary : AppTheme.border,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: AppTheme.spacingXl),

                  KonveksioButton(
                    text: 'Kirim Pengajuan',
                    onPressed: state.isLoading ? null : () => _submit(limit),
                    isLoading: state.isLoading,
                  ),
                ],
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.spacingBase),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(PhosphorIconsRegular.warningCircle, size: 48, color: AppTheme.destructive),
                const SizedBox(height: AppTheme.spacingBase),
                Text(
                  'Gagal memuat limit kasbon',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: AppTheme.spacingSm),
                Text(
                  error.toString(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.muted),
                ),
                const SizedBox(height: AppTheme.spacingBase),
                OutlinedButton(
                  onPressed: () => ref.invalidate(kasbonLimitProvider),
                  child: const Text('Coba Lagi'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLimitCard(double limit) {
    final rawText = _amountController.text.replaceAll(RegExp(r'[^0-9]'), '');
    final amount = double.tryParse(rawText) ?? 0.0;
    final isExceeded = amount > limit;

    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingBase),
      decoration: BoxDecoration(
        color: isExceeded ? AppTheme.destructive.withValues(alpha: 0.1) : AppTheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(
          color: isExceeded ? AppTheme.destructive.withValues(alpha: 0.3) : AppTheme.primary.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppTheme.spacingSm),
            decoration: BoxDecoration(
              color: isExceeded ? AppTheme.destructive.withValues(alpha: 0.2) : AppTheme.primary.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              PhosphorIconsRegular.wallet,
              color: isExceeded ? AppTheme.destructive : AppTheme.primary,
            ),
          ),
          const SizedBox(width: AppTheme.spacingBase),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sisa Limit Kasbon Anda',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isExceeded ? AppTheme.destructive : AppTheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  AppFormatters.formatCurrency(limit),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isExceeded ? AppTheme.destructive : AppTheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    final intValue = int.tryParse(newValue.text);
    if (intValue == null) return oldValue;

    final formatter = NumberFormat.decimalPattern('id');
    final newText = formatter.format(intValue);

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
