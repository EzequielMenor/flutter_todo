import 'package:flutter/material.dart';
import 'package:material/models/tarea.dart';
import 'package:material/screens/pagina_agregar_tarea.dart';
import 'package:material/screens/pagina_principal.dart';

class Rutas {
  static const String paginaPrincipal = "/";
  static const String agregarTarea = "/agregar_tarea";

  static Route<dynamic> generarRuta(RouteSettings settings) {
    switch (settings.name) {
      case paginaPrincipal:
        return MaterialPageRoute(builder: (context) => const PaginaPrincipal());
      case agregarTarea:
        final tarea = settings.arguments as Tarea?;
        return MaterialPageRoute(
          builder: (context) => PaginaAgregarTarea(tareaParaEditar: tarea),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(child: Text("Error: Ruta no encontrada")),
          ),
        );
    }
  }
}
