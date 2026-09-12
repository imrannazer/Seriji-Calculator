import 'package:flutter/material.dart';
import '../../../../theme/siraji_colors.dart';
import '../../../../theme/siraji_spacing.dart';
import '../../../../theme/siraji_typography.dart';

class StepProgressIndicator extends StatelessWidget {
  const StepProgressIndicator({
    super.key,
    required this.currentStep,
    required this.steps,
  });

  final int currentStep;
  final List<String> steps;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: SirajiSpacing.md,
        vertical: SirajiSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: SirajiColors.offWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: SirajiColors.divider),
      ),
      child: Row(
        children: List.generate(steps.length * 2 - 1, (index) {
          if (index.isOdd) {
            final stepIndex = index ~/ 2;
            final isCompleted = currentStep > stepIndex;
            return Expanded(
              child: Container(
                height: 2,
                color: isCompleted ? SirajiColors.gold : SirajiColors.divider,
              ),
            );
          }

          final stepIndex = index ~/ 2;
          final isCompleted = currentStep > stepIndex;
          final isCurrent = currentStep == stepIndex;

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCurrent
                      ? SirajiColors.deepGreen
                      : isCompleted
                          ? SirajiColors.gold
                          : SirajiColors.offWhite,
                  border: Border.all(
                    color: isCurrent
                        ? SirajiColors.deepGreen
                        : isCompleted
                            ? SirajiColors.gold
                            : SirajiColors.divider,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: isCompleted
                      ? const Icon(Icons.check, size: 16, color: SirajiColors.darkGreen)
                      : Text(
                          '${stepIndex + 1}',
                          style: SirajiTypography.labelSmall.copyWith(
                            color: isCurrent
                                ? SirajiColors.textOnDark
                                : SirajiColors.textSecondary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                steps[stepIndex],
                style: SirajiTypography.labelSmall.copyWith(
                  fontSize: 10,
                  fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w500,
                  color: isCurrent ? SirajiColors.deepGreen : SirajiColors.textSecondary,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
