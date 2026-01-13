import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:material/core/colores_app.dart';
import 'package:material/models/tarea.dart';
import 'package:material/routes/rutas.dart';
import 'package:material/widgets/logo.dart';
import 'package:material/widgets/sin_tareas.dart';
import 'package:material/widgets/tarjeta_tarea.dart';

class PaginaPrincipal extends StatefulWidget {
  const PaginaPrincipal({super.key});

  @override
  State<PaginaPrincipal> createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> {
  final List<Tarea> _tareas = [
    Tarea(
      nombre: 'Tarea 1',
      completado: false,
      descripcion: 'Descripción 1',
      id: '1',
    ),
    Tarea(
      nombre: 'Tarea 2',
      completado: true,
      descripcion: 'Descripción 2',
      id: '2',
    ),

    Tarea(
      nombre: 'Tarea 3',
      completado: false,
      descripcion: 'Descripción 3',
      id: '3',
    ),

    Tarea(
      nombre: 'Tarea 4',
      completado: true,
      descripcion: 'Descripción 4',
      id: '4',
    ),
    Tarea(
      nombre: 'Comprar víveres',
      completado: false,
      descripcion: 'Leche, huevos, pan y frutas.',
      id: '5',
    ),
    Tarea(
      nombre: 'Llamar al médico',
      completado: true,
      descripcion: 'Confirmar cita para el lunes.',
      id: '6',
    ),
    Tarea(
      nombre: 'Estudiar Flutter',
      completado: false,
      descripcion: 'Repasar widgets y estados.',
      id: '7',
    ),
  ];

  void _agregarTarea(Tarea tarea) {
    setState(() {
      _tareas.add(tarea);
    });
  }

  void _borrarTarea(int index) {
    setState(() {
      _tareas.removeAt(index);
    });
  }

  void _cambiarEstadoTarea(int indice) {
    setState(() {
      _tareas[indice].completado = !_tareas[indice].completado;
    });
  }

  void _editarTarea(int index) async {
    final tareaEditada = await Navigator.pushNamed(
      context,
      Rutas.agregarTarea,
      arguments: _tareas[index],
    );

    if (tareaEditada != null && tareaEditada is Tarea) {
      setState(() {
        _tareas[index] = tareaEditada;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Logo(),
        centerTitle: true,
        backgroundColor: ColoresApp.primario,
        elevation: 0,
      ),
      body: _tareas.isEmpty
          ? SinTareas()
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _tareas.length,
              itemBuilder: (context, index) {
                return TarjetaTarea(
                  tarea: _tareas[index],
                  onEliminar: () => _borrarTarea(index),
                  onCambiarEstado: () => _cambiarEstadoTarea(index),
                  onTap: () => _editarTarea(index),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final nuevaTarea = await Navigator.pushNamed(
            context,
            Rutas.agregarTarea,
          );

          if (nuevaTarea != null && nuevaTarea is Tarea) {
            _agregarTarea(nuevaTarea);
          }
        },
        backgroundColor: ColoresApp.primario,
        child: const Icon(Icons.add),
      ),
    );
  }
}
