import 'package:flutter/material.dart';

class SirajiColors {
  SirajiColors._();

  static const Color deepGreen = Color(0xFF0F2D20);
  static const Color mediumGreen = Color(0xFF16402C);
  static const Color darkGreen = Color(0xFF0B2016);
  static const Color gold = Color(0xFFD4A843);
  static const Color lightGold = Color(0xFFF3D78A);
  static const Color deepGold = Color(0xFFAA8030);
  static const Color cream = Color(0xFFF8F4EE);
  static const Color offWhite = Color(0xFFFDFBF7);
  static const Color divider = Color(0xFFE0D8CC);
  static const Color textPrimary = Color(0xFF1C1C1E);
  static const Color textSecondary = Color(0xFF6B6B6B);
  static const Color textOnDark = Color(0xFFF5EFE6);
  static const Color goldOnDark = Color(0xFFD4A843);
  static const Color success = Color(0xFF2E7D32);
  static const Color warning = Color(0xFFF57F17);
  static const Color error = Color(0xFFB71C1C);
  static const Color info = Color(0xFF0277BD);
  static const Color transparent = Colors.transparent;
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);

  static const LinearGradient headerGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [darkGreen, deepGreen, mediumGreen],
  );

  static const LinearGradient goldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [lightGold, gold, deepGold],
  );

  static const LinearGradient splashGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [deepGreen, darkGreen],
  );
}
