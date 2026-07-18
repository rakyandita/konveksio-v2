import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class KvxTextField extends StatefulWidget {
  final String label;
  final String? hint;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const KvxTextField({
    super.key,
    required this.label,
    this.hint,
    this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  State<KvxTextField> createState() => _KvxTextFieldState();
}

class _KvxTextFieldState extends State<KvxTextField> {
  late FocusNode _focusNode;
  bool _isFocused = false;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: AppTypography.body2.copyWith(
            fontWeight: FontWeight.w600,
            color: _errorText != null
                ? AppColors.destructive
                : (_isFocused ? AppColors.primary : AppColors.secondary),
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 48.0,
          decoration: BoxDecoration(
            color: AppColors.background, // F1F5F9 as per DS
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(
              color: _errorText != null
                  ? AppColors.destructive
                  : (_isFocused ? AppColors.primary : AppColors.border),
              width: _isFocused || _errorText != null ? 1.5 : 1.0,
            ),
          ),
          child: TextFormField(
            controller: widget.controller,
            focusNode: _focusNode,
            obscureText: widget.obscureText,
            keyboardType: widget.keyboardType,
            style: AppTypography.body1,
            cursorColor: AppColors.primary,
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: AppTypography.body1.copyWith(color: AppColors.muted),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            ),
            onChanged: (val) {
              if (widget.validator != null) {
                setState(() {
                  _errorText = widget.validator!(val);
                });
              }
            },
          ),
        ),
        if (_errorText != null) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(
            _errorText!,
            style: AppTypography.caption.copyWith(color: AppColors.destructive),
          ),
        ],
      ],
    );
  }
}
