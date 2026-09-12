import 'package:flutter/material.dart';
import '../theme/siraji_colors.dart';
import '../theme/siraji_typography.dart';
import '../theme/siraji_spacing.dart';

class SirajiHeaderTitle extends StatelessWidget {
  const SirajiHeaderTitle({
    super.key,
    required this.title,
    this.icon,
  });

  final String title;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, color: SirajiColors.gold, size: 20),
          const SizedBox(width: SirajiSpacing.xs),
        ],
        Text(
          title,
          style: SirajiTypography.titleOnDark.copyWith(
            color: SirajiColors.textOnDark,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
