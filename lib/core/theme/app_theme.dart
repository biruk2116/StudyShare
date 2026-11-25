import 'package:material_ui/material_ui.dart';

abstract final class AppColors {
  static const purple = Color(0xFF5B3CE0);
  static const navy = Color(0xFF1B1B4B);
  static const lavender = Color(0xFFEFEAFE);
  static const border = Color(0xFFD9D0F7);
  static const hint = Color(0xFF6B5FA8);
  static const teal = Color(0xFF4FB8C9);
  static const error = Color(0xFFE5484D);
}

abstract final class AppSpace {
  static const fieldGap = 12.0;
  static const controlHeight = 56.0;
  static const buttonHeight = 52.0;
  static const radius = 16.0;
}

abstract final class AppTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.purple,
      primary: AppColors.purple,
      surface: Colors.white,
      error: AppColors.error,
    ),
    fontFamily: 'Roboto',
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: AppColors.navy,
      ),
      titleLarge: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w700,
        color: AppColors.navy,
      ),
      bodyLarge: TextStyle(fontSize: 16, color: AppColors.navy),
      bodyMedium: TextStyle(fontSize: 14, color: AppColors.navy),
    ),
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      filled: true,
      fillColor: const Color(0xF2FFFFFF),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      hintStyle: const TextStyle(color: AppColors.hint, fontSize: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSpace.radius),
        borderSide: const BorderSide(color: AppColors.border, width: 1.2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSpace.radius),
        borderSide: const BorderSide(color: AppColors.border, width: 1.2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSpace.radius),
        borderSide: const BorderSide(color: AppColors.purple, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSpace.radius),
        borderSide: const BorderSide(color: AppColors.error, width: 1.3),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSpace.radius),
        borderSide: const BorderSide(color: AppColors.error, width: 1.5),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      side: const BorderSide(color: AppColors.border, width: 1.4),
    ),
  );
}
