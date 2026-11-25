import 'package:material_ui/material_ui.dart';

abstract final class AppTheme {
  static const purple = Color(0xFF6035E8);
  static const navy = Color(0xFF17134C);
  static const lavender = Color(0xFFE5DDF5);
  static const muted = Color(0xFF766B98);
  static const pageGutter = 20.0;
  static const fieldGap = 8.0;
  static const controlRadius = 17.0;
  static const contentMaxWidth = 480.0;

  static ThemeData get light => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(0xFFFEFCFF),
    colorScheme: ColorScheme.fromSeed(seedColor: purple),
    fontFamily: 'Roboto',
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        fontSize: 27,
        fontWeight: FontWeight.w800,
        color: navy,
      ),
      titleLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w800,
        color: navy,
      ),
      bodyLarge: TextStyle(fontSize: 15, color: navy),
      bodyMedium: TextStyle(fontSize: 14, color: navy),
    ),
    visualDensity: VisualDensity.standard,
  );
}
