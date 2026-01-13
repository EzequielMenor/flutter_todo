import 'package:flutter/material.dart';
import 'package:material/core/mi_tema.dart';
import 'package:material/routes/rutas.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: miTema,
      initialRoute: Rutas.paginaPrincipal,
      onGenerateRoute: Rutas.generarRuta,
    );
  }
}
