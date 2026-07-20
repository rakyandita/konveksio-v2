import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/konveksio_button.dart';
import '../../auth/presentation/auth_controller.dart';
import 'settings_branch_controller.dart';
import '../domain/branch_setting_model.dart';

class SettingsBranchScreen extends ConsumerStatefulWidget {
  const SettingsBranchScreen({super.key});

  @override
  ConsumerState<SettingsBranchScreen> createState() => _SettingsBranchScreenState();
}

class _SettingsBranchScreenState extends ConsumerState<SettingsBranchScreen> {
  final _formKey = GlobalKey<FormState>();
  final _waController = TextEditingController();
  final _bankController = TextEditingController();
  final _limitController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authState = ref.read(authControllerProvider);
      if (authState.branchId != null) {
        ref.read(settingsBranchControllerProvider.notifier).loadSetting(authState.branchId!);
      }
    });
  }

  @override
  void dispose() {
    _waController.dispose();
    _bankController.dispose();
    _limitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(settingsBranchControllerProvider);
    final authState = ref.watch(authControllerProvider);

    if (state.setting != null) {
      if (_waController.text.isEmpty) _waController.text = state.setting!.contactWa ?? '';
      if (_bankController.text.isEmpty) _bankController.text = state.setting!.bankAccountInfo ?? '';
      if (_limitController.text.isEmpty) _limitController.text = state.setting!.maxKasbonPercentage?.toString() ?? '500000';
    }

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Pengaturan Cabang'),
        backgroundColor: AppTheme.surface,
        scrolledUnderElevation: 4.0,
      ),
      body: state.isLoading && state.setting == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(AppTheme.spacingBase),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Pengaturan Profil Cabang', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: AppTheme.spacingSm),
                    TextFormField(
                      initialValue: authState.branchId ?? 'Cabang Utama',
                      decoration: const InputDecoration(labelText: 'ID Cabang (Hanya Baca)'),
                      readOnly: true,
                    ),
                    const SizedBox(height: AppTheme.spacingBase),
                    const Text('Kontak & Pembayaran (Untuk Invoice)', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: AppTheme.spacingSm),
                    TextFormField(
                      controller: _waController,
                      decoration: const InputDecoration(
                        labelText: 'Nomor WhatsApp Cabang',
                        prefixIcon: Icon(PhosphorIconsRegular.whatsappLogo),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: AppTheme.spacingBase),
                    TextFormField(
                      controller: _bankController,
                      decoration: const InputDecoration(
                        labelText: 'Informasi Rekening Bank',
                        prefixIcon: Icon(PhosphorIconsRegular.bank),
                      ),
                      maxLines: 2,
                    ),
                    const SizedBox(height: AppTheme.spacingLg),
                    const Text('Limit Keuangan', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: AppTheme.spacingSm),
                    TextFormField(
                      controller: _limitController,
                      decoration: const InputDecoration(
                        labelText: 'Maksimal Kasbon per Karyawan (Rp)',
                        prefixText: 'Rp ',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: AppTheme.spacingLg),
                    KonveksioButton(
                      text: 'SIMPAN PENGATURAN',
                      isLoading: state.isLoading,
                      onPressed: () async {
                        if (_formKey.currentState!.validate() && authState.branchId != null) {
                          final newSetting = BranchSettingModel(
                            branchId: authState.branchId!,
                            contactWa: _waController.text,
                            bankAccountInfo: _bankController.text,
                            maxKasbonPercentage: int.tryParse(_limitController.text) ?? 500000,
                          );
                          await ref.read(settingsBranchControllerProvider.notifier).updateSetting(newSetting);
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Pengaturan berhasil disimpan')),
                            );
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
