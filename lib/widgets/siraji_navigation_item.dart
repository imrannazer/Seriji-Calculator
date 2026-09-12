import 'package:flutter/material.dart';
import '../theme/siraji_colors.dart';
import '../theme/siraji_typography.dart';
import '../theme/siraji_spacing.dart';

class SirajiNavigationItem extends StatelessWidget {
  const SirajiNavigationItem({
    super.key,
    required this.icon,
    required this.primaryLabel,
    required this.secondaryLabel,
    required this.onTap,
  });

  final IconData icon;
  final String primaryLabel;
  final String secondaryLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        splashColor: SirajiColors.gold.withOpacity(0.2),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: SirajiSpacing.xs),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: SirajiColors.gold.withOpacity(0.85), size: 22),
              const SizedBox(height: 2),
              Text(
                primaryLabel,
                style: SirajiTypography.labelSmall.copyWith(
                  color: SirajiColors.textOnDark.withOpacity(0.9),
                  fontSize: 10,
                  height: 1.1,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
              ),
              Text(
                secondaryLabel,
                style: SirajiTypography.labelSmall.copyWith(
                  color: SirajiColors.textOnDark.withOpacity(0.6),
                  fontSize: 8,
                  height: 1.1,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
