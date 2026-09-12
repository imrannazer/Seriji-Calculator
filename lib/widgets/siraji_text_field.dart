import 'package:flutter/material.dart';
import '../theme/siraji_colors.dart';
import '../theme/siraji_typography.dart';

class SirajiTextField extends StatelessWidget {
  const SirajiTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.textDirection,
    this.onChanged,
    this.onSubmitted,
    this.obscureText = false,
    this.enabled = true,
    this.maxLines = 1,
    this.focusNode,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextDirection? textDirection;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final bool obscureText;
  final bool enabled;
  final int maxLines;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      textDirection: textDirection,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      obscureText: obscureText,
      enabled: enabled,
      maxLines: maxLines,
      style: SirajiTypography.bodyLarge,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        helperText: helperText,
        errorText: errorText,
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: SirajiColors.textSecondary)
            : null,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
