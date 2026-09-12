import 'package:flutter/material.dart';
import '../theme/siraji_colors.dart';
import '../theme/siraji_spacing.dart';

enum SirajiButtonVariant { primary, secondary, text }

class SirajiButton extends StatelessWidget {
  const SirajiButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = SirajiButtonVariant.primary,
    this.icon,
    this.isLoading = false,
    this.isEnabled = true,
    this.fullWidth = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final SirajiButtonVariant variant;
  final IconData? icon;
  final bool isLoading;
  final bool isEnabled;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    final child = isLoading
        ? const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: SirajiColors.textOnDark,
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18),
                const SizedBox(width: SirajiSpacing.xs),
              ],
              Text(label),
            ],
          );

    Widget button;
    switch (variant) {
      case SirajiButtonVariant.primary:
        button = ElevatedButton(
          onPressed: isEnabled && !isLoading ? onPressed : null,
          child: child,
        );
      case SirajiButtonVariant.secondary:
        button = OutlinedButton(
          onPressed: isEnabled && !isLoading ? onPressed : null,
          child: child,
        );
      case SirajiButtonVariant.text:
        button = TextButton(
          onPressed: isEnabled && !isLoading ? onPressed : null,
          child: child,
        );
    }

    if (fullWidth) {
      return SizedBox(width: double.infinity, child: button);
    }
    return button;
  }
}
