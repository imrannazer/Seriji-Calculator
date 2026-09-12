import 'package:flutter/material.dart';
import '../theme/siraji_colors.dart';
import '../theme/siraji_spacing.dart';
import '../theme/siraji_shapes.dart';
import '../theme/siraji_elevation.dart';

class SirajiCard extends StatelessWidget {
  const SirajiCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.color,
    this.elevation,
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final double? elevation;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: Material(
        color: color ?? SirajiColors.offWhite,
        elevation: elevation ?? SirajiElevation.card,
        borderRadius: BorderRadius.circular(SirajiShapes.radiusMd),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(SirajiShapes.radiusMd),
          child: Padding(
            padding: padding ?? const EdgeInsets.all(SirajiSpacing.cardPadding),
            child: child,
          ),
        ),
      ),
    );
  }
}
