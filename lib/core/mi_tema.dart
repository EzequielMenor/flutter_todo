import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material/core/colores_app.dart';

ThemeData buildTheme(Color primaryColor, Brightness brightness) {
  final isDark = brightness == Brightness.dark;
  final baseTheme = isDark ? ThemeData.dark() : ThemeData.light();

  // Basic colors based on mode
  // Basic colors based on mode
  final surface = isDark ? const Color(0xFF1E1E1E) : ColoresApp.surface;
  final surface2 = isDark
      ? const Color(0xFF121212)
      : ColoresApp.surface2; // Background
  final foreground = isDark ? Colors.white : ColoresApp.foregraund;

  return ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: surface2,
    brightness: brightness,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: brightness,
      primary: primaryColor,
      secondary: ColoresApp.secundario,
      surface: surface,
      onPrimary: Colors.white,
      onSurface: foreground,
    ),

    textTheme: GoogleFonts.interTextTheme(
      baseTheme.textTheme.copyWith(
        bodyMedium: TextStyle(color: foreground),
        bodyLarge: TextStyle(color: foreground),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
