import 'package:flutter/material.dart';

class AppTheme {
  /// Light Theme: Crisp white backgrounds, subtle shadows, and a gentle brand accent.
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    // Define a custom ColorScheme for the light theme.
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF0066CC), // Brand accent color.
      onPrimary: Colors.white,
      secondary: Color(0xFF00A1E4),
      onSecondary: Colors.white,
      surface: Colors.white,
      onSurface: Colors.black87,
      error: Colors.redAccent,
      onError: Colors.white,
    ),
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black87,
      elevation: 0,
    ),
    cardTheme: CardTheme(
      color: Colors.white,
      elevation: 2,
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black87),
      bodyMedium: TextStyle(color: Colors.black54),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF0066CC),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
  );

  /// Dark Theme: Deep charcoal backgrounds, lighter text/icons, with a consistent brand accent.
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    // Define a custom ColorScheme for the dark theme.
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFF0066CC),
      onPrimary: Colors.white,
      secondary: Color(0xFF00A1E4),
      onSecondary: Colors.white,
      surface: Color(0xFF1E1E1E),
      onSurface: Colors.white70,
      error: Colors.redAccent,
      onError: Colors.white,
    ),
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(0xFF121212),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF121212),
      foregroundColor: Colors.white70,
      elevation: 0,
    ),
    cardTheme: CardTheme(
      color: const Color(0xFF1E1E1E),
      elevation: 2,
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white70),
      bodyMedium: TextStyle(color: Colors.white60),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF0066CC),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
  );
}
