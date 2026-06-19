import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData get light => _theme(
        ColorScheme.fromSeed(
          seedColor: AppColors.deepIndigo,
          brightness: Brightness.light,
          primary: AppColors.deepIndigo,
          secondary: AppColors.modernPurple,
          tertiary: AppColors.emerald,
          error: AppColors.error,
          surface: Colors.white,
        ),
      );

  static ThemeData get dark => _theme(
        ColorScheme.fromSeed(
          seedColor: AppColors.modernPurple,
          brightness: Brightness.dark,
          primary: AppColors.modernPurple,
          secondary: AppColors.skyBlue,
          tertiary: AppColors.emerald,
          error: AppColors.error,
          surface: const Color(0xFF12172A),
        ),
      );

  static ThemeData _theme(ColorScheme scheme) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor:
          scheme.brightness == Brightness.dark ? AppColors.night : AppColors.paper,
      fontFamily: 'Roboto',
      appBarTheme: const AppBarTheme(centerTitle: false, elevation: 0),
      cardTheme: CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      ),
      navigationBarTheme: NavigationBarThemeData(
        indicatorShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(48, 52),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        ),
      ),
    );
  }
}
