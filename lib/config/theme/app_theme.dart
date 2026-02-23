import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFF1E1E2E),
    primaryColor: const Color(0xFF4CAF50),
    colorScheme: ColorScheme.dark(
      primary: const Color.fromARGB(255, 69, 121, 218),
      secondary: const Color(0xFF2196F3),
      background: const Color(0xFF1E1E2E),
      surface: const Color(0xFF2A2A3B),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onBackground: Colors.white,
      onSurface: Colors.white,
      error: const Color(0xFFFF5C5C),
      onError: Colors.white,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFFE5E5E5), fontSize: 16),
      bodyMedium: TextStyle(color: Color(0xFFE5E5E5), fontSize: 14),
      titleLarge: TextStyle(
        color: Color(0xFFE5E5E5),
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      titleMedium: TextStyle(color: Color(0xFFAAAAAA), fontSize: 14),
      titleSmall: TextStyle(color: Color(0xFFAAAAAA), fontSize: 12),
      labelLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF1E1E2E),
      hintStyle: const TextStyle(color: Color(0xFFAAAAAA)),
      labelStyle: const TextStyle(color: Color(0xFFE5E5E5)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF3C3C3C)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF3C3C3C)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF4CAF50)),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFFF5C5C)),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 50, 61, 180),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: const Color(0xFF2196F3)),
    ),
  );
}
