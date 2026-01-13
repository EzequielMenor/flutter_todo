import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material/core/colores_app.dart';

final miTema = ThemeData(
  primaryColor: ColoresApp.primario,
  scaffoldBackgroundColor: ColoresApp.surface2,
  colorScheme: const ColorScheme.highContrastLight(
    primary: ColoresApp.primario,
    secondary: ColoresApp.secundario,
    surface: ColoresApp.surface,
    onPrimary: ColoresApp.foregraund,
    onSurface: ColoresApp.foregraund,
  ),

  textTheme: GoogleFonts.interTextTheme(
    ThemeData.light().textTheme.copyWith(
      bodyMedium: const TextStyle(color: ColoresApp.foregraund),
      bodyLarge: const TextStyle(color: ColoresApp.foregraund),
    ),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: ColoresApp.primario,
      foregroundColor: ColoresApp.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    ),
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
);
