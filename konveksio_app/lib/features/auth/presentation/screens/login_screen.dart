import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:konveksio_app/core/theme/app_theme.dart';
import 'package:konveksio_app/features/auth/providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _phoneController = TextEditingController();
  final _pinController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  bool _isPasswordVisible = false;
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
      _errorMessage = null;
    });

    try {
      await ref.read(authControllerProvider.notifier).login(
        _phoneController.text.trim(),
        _pinController.text,
      );
      // Redirect is handled by go_router listening to auth state
    } on AuthException catch (_) {
      setState(() {
        _errorMessage = "Nomor HP atau PIN salah.";
      });
    } catch (e) {
      setState(() {
        _errorMessage = "Terjadi kesalahan koneksi. Silakan coba lagi.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final isLoading = authState.isLoading;

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppTheme.spaceLg),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.factory,
                    size: 64,
                    color: AppTheme.primary,
                  ),
                  const SizedBox(height: AppTheme.spaceLg),
                  Text(
                    'Masuk ke Konveksio',
                    style: Theme.of(context).textTheme.displayLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppTheme.spaceSm),
                  Text(
                    'Silakan masukkan nomor HP dan PIN Anda',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.muted,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppTheme.spaceXl),
                  
                  // Phone Input
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Nomor HP',
                      hintText: 'Contoh: 081234567890',
                      prefixIcon: Icon(Icons.phone_android),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Nomor HP tidak boleh kosong';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: AppTheme.spaceMd),
                  
                  // PIN Input
                  TextFormField(
                    controller: _pinController,
                    keyboardType: TextInputType.number,
                    obscureText: !_isPasswordVisible,
                    maxLength: 6,
                    decoration: InputDecoration(
                      labelText: 'PIN (6 Digit)',
                      hintText: 'Masukkan 6 digit PIN',
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                      counterText: "",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'PIN tidak boleh kosong';
                      }
                      if (value.length < 6) {
                        return 'PIN harus 6 digit';
                      }
                      return null;
                    },
                    onFieldSubmitted: (_) => _handleLogin(),
                  ),
                  
                  if (_errorMessage != null) ...[
                    const SizedBox(height: AppTheme.spaceSm),
                    Text(
                      _errorMessage!,
                      style: TextStyle(
                        color: AppTheme.destructive,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                  
                  const SizedBox(height: AppTheme.spaceXl),
                  
                  ElevatedButton(
                    onPressed: isLoading ? null : _handleLogin,
                    child: isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: AppTheme.onPrimary,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text('MASUK'),
                  ),
                  
                  const SizedBox(height: AppTheme.spaceMd),
                  
                  TextButton(
                    onPressed: () {
                      // Lupa PIN logic
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Fitur Lupa PIN akan segera hadir'),
                          backgroundColor: AppTheme.secondary,
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: AppTheme.primary,
                      minimumSize: const Size.fromHeight(48),
                    ),
                    child: const Text(
                      'Lupa PIN?',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
