import 'package:flutter/material.dart';
import 'package:material/core/mi_tema.dart';
import 'package:material/core/theme_manager.dart';
import 'package:material/routes/rutas.dart';

/// Punto de entrada de la aplicación.
void main() {
  runApp(const MainApp());
}

/// Widget principal de la aplicación.
///
/// Configura el [MaterialApp], el tema y las rutas.
class MainApp extends StatelessWidget {
  /// Constructor constante de la aplicación.
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: ThemeManager(),
      builder: (context, child) {
        final themeManager = ThemeManager();
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: buildTheme(themeManager.primaryColor, Brightness.light),
          darkTheme: buildTheme(themeManager.primaryColor, Brightness.dark),
          themeMode: themeManager.themeMode,
          initialRoute: Rutas.paginaPrincipal,
          onGenerateRoute: Rutas.generarRuta,
        );
      },
    );
  }
}
