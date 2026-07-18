import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import '../../../core/theme/app_theme.dart';
import '../domain/auth_state.dart';
import 'auth_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _phoneController = TextEditingController();
  final _pinController = TextEditingController();
  bool _isPinVisible = false;
  bool _rememberMe = true;

  @override
  void dispose() {
    _phoneController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    final phone = _phoneController.text.trim();
    final pin = _pinController.text.trim();

    if (phone.isEmpty || pin.isEmpty) {
      _showSnackbar('Waduh, nomor HP dan kata sandi wajib diisi ya.', AppTheme.destructive, PhosphorIconsFill.warningCircle);
      return;
    }

    ref.read(authControllerProvider.notifier).login(phone, pin);
  }

  void _showSnackbar(String message, Color bgColor, IconData iconData) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(iconData, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: bgColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthState>(authControllerProvider, (previous, next) {
      if (next.errorMessage != null && next.errorMessage != previous?.errorMessage) {
        _showSnackbar(next.errorMessage!, AppTheme.destructive, PhosphorIconsFill.warningCircle);
      }
    });

    final authState = ref.watch(authControllerProvider);
    final showForgotPassword = authState.failedAttempts >= 5;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE0F2FE), Colors.white, Colors.white],
            stops: [0.0, 0.25, 1.0],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(flex: 2),
                // Brand
                Center(
                  child: Column(
                    children: [
                      Icon(PhosphorIconsFill.tShirt, size: 64, color: AppTheme.primary),
                      const SizedBox(height: 16),
                      Text('Konveksio', style: Theme.of(context).textTheme.displaySmall?.copyWith(color: AppTheme.primary)),
                      const SizedBox(height: 4),
                      Text('Biar Konveksio yang atur, kamu yang pantau.', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.muted)),
                    ],
                  ),
                ),
                const SizedBox(height: 48),

                // Phone Input (Outline Group Style)
                _buildInputGroup(
                  label: 'Nomor HP',
                  icon: PhosphorIcons.phone,
                  child: TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      hintText: '08...',
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      filled: false,
                      contentPadding: EdgeInsets.only(left: 12),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // PIN Input
                _buildInputGroup(
                  label: 'PIN',
                  icon: PhosphorIcons.lockKey,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _pinController,
                          obscureText: !_isPinVisible,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: '••••••••',
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            filled: false,
                            contentPadding: EdgeInsets.only(left: 12),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          _isPinVisible ? PhosphorIcons.eyeSlash : PhosphorIcons.eye,
                          color: AppTheme.primary,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPinVisible = !_isPinVisible;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Options Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Switch(
                          value: _rememberMe,
                          onChanged: (val) => setState(() => _rememberMe = val),
                          activeColor: AppTheme.primary,
                        ),
                        const Text('Ingat Saya', style: TextStyle(color: AppTheme.foreground)),
                      ],
                    ),
                    if (showForgotPassword)
                      TextButton(
                        onPressed: () {},
                        child: const Text('Lupa Password?'),
                      )
                    else
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(foregroundColor: AppTheme.muted),
                        child: const Text('Lupa Password?'),
                      ),
                  ],
                ),
                const SizedBox(height: 32),

                // Login Row
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 56,
                        child: ElevatedButton(
                          onPressed: authState.isLoading ? null : _handleLogin,
                          child: authState.isLoading
                              ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                              : const Text('Login'),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppTheme.border),
                      ),
                      child: IconButton(
                        icon: Icon(PhosphorIcons.fingerprint, color: AppTheme.primary, size: 28),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                
                const Spacer(flex: 3),
                // Help Section
                Center(
                  child: Column(
                    children: [
                      Icon(PhosphorIcons.question, color: AppTheme.primary, size: 24),
                      const SizedBox(height: 4),
                      const Text('Help', style: TextStyle(color: AppTheme.muted, fontSize: 12, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputGroup({required String label, required IconData icon, required Widget child}) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 56,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppTheme.border),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Icon(icon, color: AppTheme.muted, size: 20),
              Expanded(child: child),
            ],
          ),
        ),
        Positioned(
          top: -10,
          left: 16,
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              label,
              style: const TextStyle(fontSize: 12, color: AppTheme.muted),
            ),
          ),
        ),
      ],
    );
  }
}
