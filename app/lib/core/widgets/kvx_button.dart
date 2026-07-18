import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

enum KvxButtonVariant { primary, secondary, destructive }

class KvxButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final KvxButtonVariant variant;
  final bool isFullWidth;
  final bool isLoading;

  const KvxButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = KvxButtonVariant.primary,
    this.isFullWidth = true,
    this.isLoading = false,
  });

  @override
  State<KvxButton> createState() => _KvxButtonState();
}

class _KvxButtonState extends State<KvxButton> with SingleTickerProviderStateMixin {
  bool _isPressed = false;

  void _handleTapDown(TapDownDetails details) {
    if (widget.onPressed != null && !widget.isLoading) {
      setState(() => _isPressed = true);
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.onPressed != null && !widget.isLoading) {
      setState(() => _isPressed = false);
      widget.onPressed!();
    }
  }

  void _handleTapCancel() {
    if (_isPressed) {
      setState(() => _isPressed = false);
    }
  }

  Color get _backgroundColor {
    if (widget.onPressed == null) return AppColors.border; // Disabled state
    switch (widget.variant) {
      case KvxButtonVariant.primary:
        return AppColors.primary;
      case KvxButtonVariant.secondary:
        return AppColors.surface;
      case KvxButtonVariant.destructive:
        return AppColors.destructive;
    }
  }

  Color get _textColor {
    if (widget.onPressed == null) return AppColors.muted;
    switch (widget.variant) {
      case KvxButtonVariant.primary:
      case KvxButtonVariant.destructive:
        return AppColors.surface;
      case KvxButtonVariant.secondary:
        return AppColors.foreground;
    }
  }

  Border? get _border {
    if (widget.variant == KvxButtonVariant.secondary) {
      return Border.all(
        color: widget.onPressed == null ? AppColors.border : AppColors.secondary,
        width: 1.5,
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // Touch target minimum is 44pt (ui-ux-pro-max standard), 
    // we use 48dp for even better thumb-friendly area.
    Widget content = AnimatedContainer(
      duration: const Duration(milliseconds: 150), // Fast micro-interaction
      height: 48.0,
      width: widget.isFullWidth ? double.infinity : null,
      padding: EdgeInsets.symmetric(
        horizontal: widget.isFullWidth ? 0 : AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: _border,
      ),
      // Scale down slightly when pressed
      transform: Matrix4.diagonal3Values(
        _isPressed ? 0.98 : 1.0,
        _isPressed ? 0.98 : 1.0,
        1.0,
      ),
      transformAlignment: Alignment.center,
      child: Center(
        child: widget.isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(_textColor),
                ),
              )
            : Text(
                widget.text,
                style: AppTypography.body1.copyWith(
                  fontWeight: FontWeight.w600,
                  color: _textColor,
                ),
              ),
      ),
    );

    return Semantics(
      button: true,
      enabled: widget.onPressed != null,
      child: GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        child: content,
      ),
    );
  }
}
