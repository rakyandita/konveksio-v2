import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/konveksio_button.dart';
import '../../../../core/widgets/konveksio_text_field.dart';
import '../owner_cabang_controller.dart';

class OwnerBranchFormModal {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const _OwnerBranchFormModalContent(),
    );
  }
}

class _OwnerBranchFormModalContent extends ConsumerStatefulWidget {
  const _OwnerBranchFormModalContent();

  @override
  ConsumerState<_OwnerBranchFormModalContent> createState() => _OwnerBranchFormModalContentState();
}

class _OwnerBranchFormModalContentState extends ConsumerState<_OwnerBranchFormModalContent> {
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;

    setState(() => _isLoading = true);
    try {
      await ref.read(ownerCabangControllerProvider.notifier).addBranch(
        name,
        _addressController.text.trim(),
        _phoneController.text.trim(),
      );
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cabang berhasil ditambahkan')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return Container(
      decoration: const BoxDecoration(
        color: AppTheme.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppTheme.radiusLg)),
      ),
      padding: EdgeInsets.only(
        left: AppTheme.spacingBase,
        right: AppTheme.spacingBase,
        top: AppTheme.spacingBase,
        bottom: bottomInset + AppTheme.spacingBase,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Tambah Cabang Baru', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              IconButton(
                icon: const Icon(PhosphorIconsRegular.x),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingBase),
          KonveksioTextField(
            controller: _nameController,
            label: 'Nama Cabang',
            hintText: 'Contoh: Cabang Serang 2',
            prefixIcon: const Icon(PhosphorIconsRegular.storefront),
          ),
          const SizedBox(height: AppTheme.spacingSm),
          KonveksioTextField(
            controller: _addressController,
            label: 'Alamat Cabang',
            hintText: 'Alamat lengkap lokasi workshop',
            maxLines: 2,
            prefixIcon: const Icon(PhosphorIconsRegular.mapPin),
          ),
          const SizedBox(height: AppTheme.spacingSm),
          KonveksioTextField(
            controller: _phoneController,
            label: 'Nomor Kontak (WhatsApp)',
            hintText: 'Contoh: 081234567890',
            keyboardType: TextInputType.phone,
            prefixIcon: const Icon(PhosphorIconsRegular.whatsappLogo),
          ),
          const SizedBox(height: AppTheme.spacingXl),
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : KonveksioButton(
                  text: 'Simpan Cabang',
                  onPressed: _submit,
                ),
        ],
      ),
    );
  }
}
