import 'package:flutter/material.dart';

class AppColors {
  // Cores Principais (index.css)
  static const Color primary = Color(0xFF1A73E8);
  static const Color primaryDark = Color(0xFF1557B0);
  static const Color primaryLightLight = Color(0xFFE8F0FE);
  static const Color primaryLightDark = Color(0xFF1A233A);

  // Status
  static const Color success = Color(0xFF34A853);
  static const Color danger = Color(0xFFEA4335);
  static const Color warning = Color(0xFFFBBC04);

  // Modo Claro
  static const Color bgLight = Color(0xFFF8F9FA);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color textLight = Color(0xFF202124);
  static const Color textSecondaryLight = Color(0xFF5F6368);
  static const Color borderLight = Color(0xFFDADCE0);

  // Modo Escuro
  static const Color bgDark = Color(0xFF121212);
  static const Color surfaceDark = Color(0xFF1E1E1E);
  static const Color textDark = Color(0xFFF5F5F5);
  static const Color textSecondaryDark = Color(0xFFA0A0A0);
  static const Color borderDark = Color(0xFF333333);
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.bgLight,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.primaryDark,
        surface: AppColors.surfaceLight,
        error: AppColors.danger,
        onSurface: AppColors.textLight,
      ),
      cardTheme: CardTheme(
        color: AppColors.surfaceLight,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppColors.borderLight),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.surfaceLight,
        foregroundColor: AppColors.textLight,
        elevation: 0,
        scrolledUnderElevation: 1,
      ),
      dividerColor: AppColors.borderLight,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.bgDark,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.primaryDark,
        surface: AppColors.surfaceDark,
        error: AppColors.danger,
        onSurface: AppColors.textDark,
      ),
      cardTheme: CardTheme(
        color: AppColors.surfaceDark,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppColors.borderDark),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.surfaceDark,
        foregroundColor: AppColors.textDark,
        elevation: 0,
        scrolledUnderElevation: 1,
      ),
      dividerColor: AppColors.borderDark,
    );
  }
}