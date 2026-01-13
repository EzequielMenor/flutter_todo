import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:material/core/colores_app.dart';
import 'package:material/models/tarea.dart';
import 'package:material/widgets/logo.dart';

class PaginaAgregarTarea extends StatefulWidget {
  final Tarea? tareaParaEditar;

  @Preview(name: "PaginaAgregarTareaPreview")
  const PaginaAgregarTarea({super.key, this.tareaParaEditar});

  @override
  State<PaginaAgregarTarea> createState() => _PaginaAgregarTareaState();
}

class _PaginaAgregarTareaState extends State<PaginaAgregarTarea> {
  late TextEditingController _nombreController;
  late TextEditingController _descripcionController;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(
      text: widget.tareaParaEditar?.nombre ?? '',
    );
    _descripcionController = TextEditingController(
      text: widget.tareaParaEditar?.descripcion ?? '',
    );
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _descripcionController.dispose();
    super.dispose();
  }

  void _guardarTarea() {
    if (_nombreController.text.isEmpty) return;

    final nuevaTarea = Tarea(
      id:
          widget.tareaParaEditar?.id ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      nombre: _nombreController.text,
      descripcion: _descripcionController.text,
      completado: widget.tareaParaEditar?.completado ?? false,
    );

    Navigator.pop(context, nuevaTarea);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Logo(),
        centerTitle: true,
        backgroundColor: ColoresApp.primario,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 16.0),
              TextField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Nombre de la tarea',
                  contentPadding: EdgeInsets.all(16.0),
                  label: Text('Nombre de la tarea'),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _descripcionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Descripción (opcional)',
                  contentPadding: EdgeInsets.all(16.0),
                  label: Text('Descripción'),
                ),
              ),
              const SizedBox(height: 24.0),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _guardarTarea,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColoresApp.primario,
                  ),
                  child: const Text('Agregar'),
                ),
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
