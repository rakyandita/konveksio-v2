import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/konveksio_button.dart';
import '../../../../core/widgets/konveksio_text_field.dart';

class KaryawanEditProfilFormModal {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const _KaryawanEditProfilFormModalContent(),
    );
  }
}

class _KaryawanEditProfilFormModalContent extends StatefulWidget {
  const _KaryawanEditProfilFormModalContent();

  @override
  State<_KaryawanEditProfilFormModalContent> createState() => _KaryawanEditProfilFormModalContentState();
}

class _KaryawanEditProfilFormModalContentState extends State<_KaryawanEditProfilFormModalContent> {
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      final supabase = Supabase.instance.client;
      final user = supabase.auth.currentUser;
      if (user != null) {
        final profile = await supabase
            .from('profiles')
            .select('name')
            .eq('id', user.id)
            .single();
        _nameController.text = profile['name'] as String? ?? '';
      }
    } catch (e) {
      _errorMessage = 'Gagal memuat profil: $e';
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _saveProfile() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final supabase = Supabase.instance.client;
      final user = supabase.auth.currentUser;
      if (user == null) throw Exception('Sesi tidak valid');

      // Update Name
      final newName = _nameController.text.trim();
      if (newName.isNotEmpty) {
        await supabase.from('profiles').update({'name': newName}).eq('id', user.id);
      }

      // Update Password (if provided)
      final newPassword = _passwordController.text;
      if (newPassword.isNotEmpty) {
        await supabase.auth.updateUser(UserAttributes(password: newPassword));
      }

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profil berhasil diperbarui')),
        );
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Gagal menyimpan profil: $e';
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
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
              const Text('Edit Profil', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              IconButton(
                icon: const Icon(PhosphorIconsRegular.x),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingBase),
          if (_errorMessage != null)
            Padding(
              padding: const EdgeInsets.only(bottom: AppTheme.spacingBase),
              child: Text(_errorMessage!, style: const TextStyle(color: AppTheme.destructive, fontSize: 14)),
            ),
          if (_isLoading)
            const Center(child: CircularProgressIndicator())
          else ...[
            KonveksioTextField(
              label: 'Nama Lengkap',
              controller: _nameController,
              prefixIcon: const Icon(PhosphorIconsRegular.user),
            ),
            const SizedBox(height: AppTheme.spacingSm),
            KonveksioTextField(
              label: 'Ubah Kata Sandi (Opsional)',
              controller: _passwordController,
              hintText: 'Biarkan kosong jika tidak diubah',
              obscureText: true,
              prefixIcon: const Icon(PhosphorIconsRegular.lock),
            ),
            const SizedBox(height: AppTheme.spacingSm),
            const Text('Catatan: Untuk mengubah divisi atau tarif ongkos, silakan hubungi Boss Cabang Anda.', style: TextStyle(color: AppTheme.muted, fontSize: 12)),
            const SizedBox(height: AppTheme.spacingXl),
            KonveksioButton(
              text: 'Simpan Profil',
              onPressed: _saveProfile,
            ),
          ],
        ],
      ),
    );
  }
}
