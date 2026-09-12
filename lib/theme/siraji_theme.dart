import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'siraji_colors.dart';
import 'siraji_typography.dart';
import 'siraji_shapes.dart';

class SirajiTheme {
  SirajiTheme._();

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: _colorScheme,
      textTheme: _textTheme,
      scaffoldBackgroundColor: SirajiColors.cream,
      appBarTheme: _appBarTheme,
      cardTheme: _cardTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
      outlinedButtonTheme: _outlinedButtonTheme,
      textButtonTheme: _textButtonTheme,
      inputDecorationTheme: _inputDecorationTheme,
      dividerTheme: _dividerTheme,
      dialogTheme: _dialogTheme,
    );
  }

  static ColorScheme get _colorScheme => const ColorScheme(
        brightness: Brightness.light,
        primary: SirajiColors.deepGreen,
        onPrimary: SirajiColors.textOnDark,
        primaryContainer: SirajiColors.mediumGreen,
        onPrimaryContainer: SirajiColors.textOnDark,
        secondary: SirajiColors.gold,
        onSecondary: SirajiColors.textPrimary,
        secondaryContainer: SirajiColors.lightGold,
        onSecondaryContainer: SirajiColors.textPrimary,
        surface: SirajiColors.offWhite,
        onSurface: SirajiColors.textPrimary,
        error: SirajiColors.error,
        onError: SirajiColors.white,
        outline: SirajiColors.divider,
        shadow: SirajiColors.darkGreen,
      );

  static TextTheme get _textTheme => const TextTheme(
        headlineLarge: SirajiTypography.headlineLarge,
        headlineMedium: SirajiTypography.headlineMedium,
        titleLarge: SirajiTypography.titleLarge,
        titleMedium: SirajiTypography.titleMedium,
        bodyLarge: SirajiTypography.bodyLarge,
        bodyMedium: SirajiTypography.bodyMedium,
        bodySmall: SirajiTypography.bodySmall,
        labelLarge: SirajiTypography.labelLarge,
        labelMedium: SirajiTypography.labelMedium,
        labelSmall: SirajiTypography.labelSmall,
      );

  static AppBarTheme get _appBarTheme => const AppBarTheme(
        backgroundColor: SirajiColors.deepGreen,
        foregroundColor: SirajiColors.textOnDark,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: SirajiColors.darkGreen,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      );

  static CardThemeData get _cardTheme => CardThemeData(
        color: SirajiColors.offWhite,
        elevation: 2,
        shape: SirajiShapes.cardShape,
        margin: EdgeInsets.zero,
      );

  static ElevatedButtonThemeData get _elevatedButtonTheme =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: SirajiColors.deepGreen,
          foregroundColor: SirajiColors.textOnDark,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: SirajiShapes.buttonShape,
          textStyle: SirajiTypography.labelLarge,
        ),
      );

  static OutlinedButtonThemeData get _outlinedButtonTheme =>
      OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: SirajiColors.deepGreen,
          side: const BorderSide(color: SirajiColors.deepGreen, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: SirajiShapes.buttonShape,
          textStyle: SirajiTypography.labelLarge,
        ),
      );

  static TextButtonThemeData get _textButtonTheme => TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: SirajiColors.deepGreen,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          textStyle: SirajiTypography.labelLarge,
        ),
      );

  static InputDecorationTheme get _inputDecorationTheme =>
      InputDecorationTheme(
        filled: true,
        fillColor: SirajiColors.offWhite,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: SirajiColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: SirajiColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide:
              const BorderSide(color: SirajiColors.deepGreen, width: 2),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      );

  static DividerThemeData get _dividerTheme => const DividerThemeData(
        color: SirajiColors.divider,
        thickness: 1,
        space: 1,
      );

  static DialogThemeData get _dialogTheme => DialogThemeData(
        shape: SirajiShapes.dialogShape,
        backgroundColor: SirajiColors.offWhite,
        elevation: 16,
      );
}
