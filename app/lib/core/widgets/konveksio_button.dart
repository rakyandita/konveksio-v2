import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

enum KonveksioButtonType { primary, secondary, destructive }

class KonveksioButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final KonveksioButtonType type;
  final bool isFullWidth;
  final IconData? icon;

  const KonveksioButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = KonveksioButtonType.primary,
    this.isFullWidth = true,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.lightTheme;
    final primaryColor = theme.colorScheme.primary;
    final destructiveColor = theme.colorScheme.error;

    // Define colors based on button type
    Color backgroundColor;
    Color foregroundColor;
    BorderSide? side;

    switch (type) {
      case KonveksioButtonType.primary:
        backgroundColor = primaryColor;
        foregroundColor = Colors.white;
        break;
      case KonveksioButtonType.destructive:
        backgroundColor = destructiveColor;
        foregroundColor = Colors.white;
        break;
      case KonveksioButtonType.secondary:
        backgroundColor = Colors.white;
        foregroundColor = const Color(0xFF020617);
        side = const BorderSide(color: Color(0xFFE2E8F0), width: 1.5);
        break;
    }

    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      disabledBackgroundColor: backgroundColor.withValues(alpha: 0.5),
      disabledForegroundColor: foregroundColor.withValues(alpha: 0.5),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
      elevation: 0,
      side: side,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.borderRadius),
      ),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        fontFamily: 'Open Sans', // Matches DS body font, wait buttons often use bold OpenSans or Poppins. SOT says: text SemiBold 16px.
      ),
    );

    Widget buttonChild;
    if (icon != null) {
      buttonChild = Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Text(text),
        ],
      );
    } else {
      buttonChild = Text(text);
    }

    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      child: ElevatedButton(
        onPressed: onPressed,
        style: buttonStyle,
        child: buttonChild,
      ),
    );
  }
}
