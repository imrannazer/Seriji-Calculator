import 'package:flutter/material.dart';
import '../theme/siraji_colors.dart';
import '../theme/siraji_typography.dart';

class SirajiSelectedNavigationItem extends StatelessWidget {
  const SirajiSelectedNavigationItem({
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
      child: GestureDetector(
        onTap: onTap,
        child: Transform.translate(
          offset: const Offset(0, -12),
          child: CustomPaint(
            painter: _MihrabArchPainter(),
            child: Container(
              padding: const EdgeInsets.fromLTRB(4, 6, 4, 4),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: SirajiColors.gold, size: 24),
                  const SizedBox(height: 2),
                  Text(
                    primaryLabel,
                    style: SirajiTypography.labelSmall.copyWith(
                      color: SirajiColors.gold,
                      fontWeight: FontWeight.w700,
                      fontSize: 10,
                      height: 1.1,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),
                  Text(
                    secondaryLabel,
                    style: SirajiTypography.labelSmall.copyWith(
                      color: SirajiColors.lightGold.withOpacity(0.85),
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
        ),
      ),
    );
  }
}

class _MihrabArchPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    final w = size.width;
    final h = size.height;

    // Draw Islamic Pointed / Ogee Arch outline
    path.moveTo(0, h);
    path.lineTo(0, 18);
    path.quadraticBezierTo(0, 4, w * 0.35, 2);
    path.quadraticBezierTo(w * 0.48, 0, w * 0.5, 0);
    path.quadraticBezierTo(w * 0.52, 0, w * 0.65, 2);
    path.quadraticBezierTo(w, 4, w, 18);
    path.lineTo(w, h);
    path.close();

    // Deep Green background fill
    final bgPaint = Paint()
      ..color = SirajiColors.deepGreen
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, bgPaint);

    // Glowing Gold Border Stroke
    final borderPaint = Paint()
      ..color = SirajiColors.gold
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
