import 'package:flutter/material.dart';
import 'siraji_colors.dart';

class SirajiTypography {
  SirajiTypography._();

  static const String fontPoppins = 'Poppins';
  static const String fontNastaliqUrdu = 'NotoNastaliqUrdu';
  static const String fontNaskhArabic = 'NotoNaskhArabic';

  static const TextStyle headlineLarge = TextStyle(
    fontFamily: fontPoppins,
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: SirajiColors.textPrimary,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontFamily: fontPoppins,
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: SirajiColors.textPrimary,
  );

  static const TextStyle titleLarge = TextStyle(
    fontFamily: fontPoppins,
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: SirajiColors.textPrimary,
  );

  static const TextStyle titleMedium = TextStyle(
    fontFamily: fontPoppins,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: SirajiColors.textPrimary,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontPoppins,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: SirajiColors.textPrimary,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontPoppins,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: SirajiColors.textPrimary,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontPoppins,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: SirajiColors.textSecondary,
  );

  static const TextStyle labelLarge = TextStyle(
    fontFamily: fontPoppins,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: SirajiColors.textPrimary,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: fontPoppins,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: SirajiColors.textPrimary,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: fontPoppins,
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: SirajiColors.textSecondary,
  );

  static const TextStyle urduDisplay = TextStyle(
    fontFamily: fontNastaliqUrdu,
    fontSize: 26,
    fontWeight: FontWeight.w700,
    color: SirajiColors.textPrimary,
  );

  static const TextStyle urduBody = TextStyle(
    fontFamily: fontNastaliqUrdu,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: SirajiColors.textPrimary,
    height: 1.8,
  );

  static const TextStyle arabicHeadline = TextStyle(
    fontFamily: fontNaskhArabic,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: SirajiColors.textPrimary,
  );

  static const TextStyle arabicBody = TextStyle(
    fontFamily: fontNaskhArabic,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: SirajiColors.textPrimary,
    height: 1.6,
  );

  static TextStyle get titleOnDark =>
      titleLarge.copyWith(color: SirajiColors.textOnDark);

  static TextStyle get bodyOnDark =>
      bodyMedium.copyWith(color: SirajiColors.textOnDark);
}
