import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/konveksio_button.dart';
import '../../../../core/widgets/konveksio_text_field.dart';
import '../../data/order_repository.dart';

class BossSpkFormModal {
  static void show(BuildContext context, {required String orderItemId}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _BossSpkFormModalContent(orderItemId: orderItemId),
    );
  }
}

class _BossSpkFormModalContent extends ConsumerStatefulWidget {
  final String orderItemId;
  
  const _BossSpkFormModalContent({required this.orderItemId});

  @override
  ConsumerState<_BossSpkFormModalContent> createState() => _BossSpkFormModalContentState();
}

class _BossSpkFormModalContentState extends ConsumerState<_BossSpkFormModalContent> {
  final _materialController = TextEditingController();
  final _colorController = TextEditingController();
  final _styleController = TextEditingController();

  Uint8List? _frontImageBytes;
  Uint8List? _backImageBytes;
  String? _frontImageExt;
  String? _backImageExt;

  bool _isLoading = false;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(bool isFront) async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
      if (image != null) {
        final bytes = await image.readAsBytes();
        final ext = image.name.split('.').last;
        setState(() {
          if (isFront) {
            _frontImageBytes = bytes;
            _frontImageExt = ext;
          } else {
            _backImageBytes = bytes;
            _backImageExt = ext;
          }
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Gagal memilih gambar: $e')));
      }
    }
  }

  Future<void> _saveSpk() async {
    setState(() => _isLoading = true);
    try {
      final supabase = Supabase.instance.client;
      String? frontUrl;
      String? backUrl;

      // Ensure bucket exists or just upload directly
      if (_frontImageBytes != null) {
        final path = 'spk_front_${widget.orderItemId}_${DateTime.now().millisecondsSinceEpoch}.$_frontImageExt';
        await supabase.storage.from('spk_images').uploadBinary(path, _frontImageBytes!);
        frontUrl = supabase.storage.from('spk_images').getPublicUrl(path);
      }

      if (_backImageBytes != null) {
        final path = 'spk_back_${widget.orderItemId}_${DateTime.now().millisecondsSinceEpoch}.$_backImageExt';
        await supabase.storage.from('spk_images').uploadBinary(path, _backImageBytes!);
        backUrl = supabase.storage.from('spk_images').getPublicUrl(path);
      }

      final payload = {
        'material': _materialController.text,
        'color': _colorController.text,
        'style': _styleController.text,
      };
      
      if (frontUrl != null) payload['front_image_url'] = frontUrl;
      if (backUrl != null) payload['back_image_url'] = backUrl;

      await ref.read(orderRepositoryProvider).updateSpk(widget.orderItemId, payload);
      
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('SPK berhasil disimpan')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
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
              const Text('Buat/Edit SPK Digital', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              IconButton(
                icon: const Icon(PhosphorIconsRegular.x),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingBase),
          KonveksioTextField(
            controller: _materialController,
            label: 'Bahan',
            hintText: 'Contoh: Cotton Combed 30s',
          ),
          const SizedBox(height: AppTheme.spacingSm),
          KonveksioTextField(
            controller: _colorController,
            label: 'Warna',
            hintText: 'Contoh: Navy Blue',
          ),
          const SizedBox(height: AppTheme.spacingSm),
          KonveksioTextField(
            controller: _styleController,
            label: 'Model / Style',
            hintText: 'Contoh: Lengan Pendek, Krah V-Neck',
          ),
          const SizedBox(height: AppTheme.spacingLg),
          const Text('Gambar Desain (Max 1MB)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: AppTheme.spacingSm),
          Row(
            children: [
              Expanded(
                child: _buildImageUpload(
                  label: 'Tampak Depan',
                  bytes: _frontImageBytes,
                  onTap: () => _pickImage(true),
                ),
              ),
              const SizedBox(width: AppTheme.spacingSm),
              Expanded(
                child: _buildImageUpload(
                  label: 'Tampak Belakang',
                  bytes: _backImageBytes,
                  onTap: () => _pickImage(false),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingXl),
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : KonveksioButton(
                  text: 'Simpan SPK',
                  onPressed: _saveSpk,
                ),
        ],
      ),
    );
  }

  Widget _buildImageUpload({required String label, Uint8List? bytes, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          border: Border.all(color: AppTheme.border, style: BorderStyle.solid),
        ),
        clipBehavior: Clip.hardEdge,
        child: bytes != null
            ? Image.memory(bytes, fit: BoxFit.cover)
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(PhosphorIconsRegular.uploadSimple, color: AppTheme.muted),
                  const SizedBox(height: 4),
                  Text(label, style: const TextStyle(fontSize: 12, color: AppTheme.muted)),
                ],
              ),
      ),
    );
  }
}
