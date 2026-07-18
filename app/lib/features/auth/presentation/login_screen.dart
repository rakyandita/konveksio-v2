import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/kvx_button.dart';
import '../../../core/widgets/kvx_text_field.dart';
import '../data/auth_repository.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _phoneController = TextEditingController();
  final _pinController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _phoneController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final authRepo = ref.read(authRepositoryProvider);
      await authRepo.signInWithPhone(
        _phoneController.text,
        _pinController.text,
      );
      
      if (mounted) {
        context.go('/');
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceAll('Exception: ', '');
      });
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.pagePadding),
            child: Container(
              constraints: const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Logo / Brand (Simulasi)
                    const Icon(
                      Icons.factory_rounded,
                      size: 64,
                      color: AppColors.primary,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      'Konveksio',
                      textAlign: TextAlign.center,
                      style: AppTypography.h1,
                    ),
                    Text(
                      'Masuk untuk mengelola operasional',
                      textAlign: TextAlign.center,
                      style: AppTypography.body2.copyWith(color: AppColors.muted),
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    if (_errorMessage != null) ...[
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          color: AppColors.statusBatalBg,
                          borderRadius: BorderRadius.circular(AppRadius.md),
                          border: Border.all(color: AppColors.statusBatalText),
                        ),
                        child: Text(
                          _errorMessage!,
                          style: AppTypography.caption.copyWith(
                            color: AppColors.statusBatalText,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                    ],

                    KvxTextField(
                      label: 'Nomor HP',
                      hint: 'Contoh: 081234567890',
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Nomor HP tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSpacing.md),
                    KvxTextField(
                      label: 'PIN',
                      hint: '6 digit angka',
                      controller: _pinController,
                      obscureText: true,
                      keyboardType: TextInputType.number,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'PIN tidak boleh kosong';
                        }
                        if (val.length < 6) {
                          return 'PIN harus 6 digit';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    KvxButton(
                      text: 'MASUK',
                      isLoading: _isLoading,
                      onPressed: _handleLogin,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
