import 'package:flutter/material.dart';
import '../theme/siraji_colors.dart';
import '../theme/siraji_typography.dart';

class SirajiLogo extends StatelessWidget {
  const SirajiLogo({super.key, this.height = 36});
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'SIRAJI',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: SirajiColors.textOnDark,
                  letterSpacing: 1.5,
                ),
              ),
              Text(
                'سراجي',
                style: SirajiTypography.arabicHeadline.copyWith(
                  color: SirajiColors.gold,
                  fontSize: 11,
                  height: 1.1,
                ),
              ),
            ],
          ),
          const SizedBox(width: 6),
          Image.asset(
            'assets/logos/siraji_logo.png',
            height: height,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => const Icon(
              Icons.auto_stories,
              color: SirajiColors.gold,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}
