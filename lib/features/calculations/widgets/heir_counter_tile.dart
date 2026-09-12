import 'package:flutter/material.dart';
import '../../../../theme/siraji_colors.dart';
import '../../../../theme/siraji_spacing.dart';
import '../../../../theme/siraji_typography.dart';

class HeirCounterTile extends StatelessWidget {
  const HeirCounterTile({
    super.key,
    required this.title,
    required this.count,
    required this.onIncrement,
    required this.onDecrement,
    this.subtitle,
    this.maxCount,
  });

  final String title;
  final int count;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final String? subtitle;
  final int? maxCount;

  @override
  Widget build(BuildContext context) {
    final isSelected = count > 0;

    return Container(
      margin: const EdgeInsets.only(bottom: SirajiSpacing.sm),
      padding: const EdgeInsets.symmetric(
        horizontal: SirajiSpacing.md,
        vertical: SirajiSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: isSelected
            ? SirajiColors.gold.withValues(alpha: 0.08)
            : SirajiColors.offWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? SirajiColors.gold : SirajiColors.divider,
          width: isSelected ? 1.5 : 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isSelected
                  ? SirajiColors.gold.withValues(alpha: 0.2)
                  : SirajiColors.deepGreen.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              isSelected ? Icons.person : Icons.person_outline,
              color: isSelected ? SirajiColors.deepGold : SirajiColors.deepGreen,
              size: 20,
            ),
          ),
          const SizedBox(width: SirajiSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: SirajiTypography.titleMedium.copyWith(
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected ? SirajiColors.deepGreen : SirajiColors.textPrimary,
                  ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: SirajiTypography.bodySmall.copyWith(
                      color: SirajiColors.textSecondary,
                    ),
                  ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _CounterButton(
                icon: Icons.remove,
                isEnabled: count > 0,
                onPressed: onDecrement,
              ),
              Container(
                constraints: const BoxConstraints(minWidth: 36),
                alignment: Alignment.center,
                child: Text(
                  '$count',
                  style: SirajiTypography.titleLarge.copyWith(
                    fontWeight: FontWeight.w700,
                    color: isSelected ? SirajiColors.deepGreen : SirajiColors.textSecondary,
                  ),
                ),
              ),
              _CounterButton(
                icon: Icons.add,
                isEnabled: maxCount == null || count < maxCount!,
                onPressed: onIncrement,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CounterButton extends StatelessWidget {
  const _CounterButton({
    required this.icon,
    required this.isEnabled,
    required this.onPressed,
  });

  final IconData icon;
  final bool isEnabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isEnabled
          ? SirajiColors.deepGreen
          : SirajiColors.divider.withValues(alpha: 0.5),
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: isEnabled ? onPressed : null,
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          width: 32,
          height: 32,
          child: Icon(
            icon,
            size: 16,
            color: isEnabled ? SirajiColors.textOnDark : SirajiColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
