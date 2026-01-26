import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:material/core/colores_app.dart';
import 'package:material/core/theme_manager.dart';
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
  CategoriaTarea? _filtroCategoria;
  bool? _filtroCompletado;

  final List<Tarea> _tareas = [
    Tarea(
      nombre: 'Tarea 1',
      completado: false,
      descripcion: 'Descripción 1',
      id: '1',
      categoria: CategoriaTarea.personal,
    ),
    Tarea(
      nombre: 'Tarea 2',
      completado: true,
      descripcion: 'Descripción 2',
      id: '2',
      categoria: CategoriaTarea.trabajo,
    ),
    Tarea(
      nombre: 'Tarea 3',
      completado: false,
      descripcion: 'Descripción 3',
      id: '3',
      categoria: CategoriaTarea.otro,
    ),
    Tarea(
      nombre: 'Tarea 4',
      completado: true,
      descripcion: 'Descripción 4',
      id: '4',
      categoria: CategoriaTarea.trabajo,
    ),
    Tarea(
      nombre: 'Comprar víveres',
      completado: false,
      descripcion: 'Leche, huevos, pan y frutas.',
      id: '5',
      categoria: CategoriaTarea.personal,
    ),
    Tarea(
      nombre: 'Llamar al médico',
      completado: true,
      descripcion: 'Confirmar cita para el lunes.',
      id: '6',
      categoria: CategoriaTarea.personal,
    ),
    Tarea(
      nombre: 'Estudiar Flutter',
      completado: false,
      descripcion: 'Repasar widgets y estados.',
      id: '7',
      categoria: CategoriaTarea.trabajo,
    ),
  ];

  List<Tarea> get _tareasFiltradas {
    return _tareas.where((tarea) {
      final coincideCategoria =
          _filtroCategoria == null || tarea.categoria == _filtroCategoria;
      final coincideEstado =
          _filtroCompletado == null || tarea.completado == _filtroCompletado;
      return coincideCategoria && coincideEstado;
    }).toList();
  }

  void _agregarTarea(Tarea tarea) {
    setState(() {
      _tareas.add(tarea);
    });
  }

  void _borrarTarea(Tarea tarea) {
    final index = _tareas.indexWhere((t) => t.id == tarea.id);
    if (index == -1) return;

    setState(() {
      _tareas.removeAt(index);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Tarea "${tarea.nombre}" eliminada'),
        action: SnackBarAction(
          label: 'Deshacer',
          onPressed: () {
            setState(() {
              _tareas.insert(index, tarea);
            });
          },
        ),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  void _cambiarEstadoTarea(Tarea tarea) {
    setState(() {
      final index = _tareas.indexWhere((t) => t.id == tarea.id);
      if (index != -1) {
        _tareas[index].completado = !_tareas[index].completado;
      }
    });
  }

  void _editarTarea(Tarea tarea) async {
    final tareaEditada = await Navigator.pushNamed(
      context,
      Rutas.agregarTarea,
      arguments: tarea,
    );

    if (tareaEditada != null && tareaEditada is Tarea) {
      setState(() {
        final index = _tareas.indexWhere((t) => t.id == tareaEditada.id);
        if (index != -1) {
          _tareas[index] = tareaEditada;
        }
      });
    }
  }

  void _reordenarTareas(int oldIndex, int newIndex) {
    setState(() {
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      final Tarea item = _tareas.removeAt(oldIndex);
      _tareas.insert(newIndex, item);
    });
  }

  bool get _filtrosActivos =>
      _filtroCategoria != null || _filtroCompletado != null;

  void _mostrarAjustesTema() {
    showDialog(
      context: context,
      builder: (context) {
        final themeManager = ThemeManager();
        return AlertDialog(
          title: const Text('Ajustes de Tema'),
          content: AnimatedBuilder(
            animation: themeManager,
            builder: (context, _) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Modo:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  RadioListTile<ThemeMode>(
                    title: const Text('Sistema'),
                    value: ThemeMode.system,
                    groupValue: themeManager.themeMode,
                    onChanged: (val) => themeManager.setThemeMode(val!),
                  ),
                  RadioListTile<ThemeMode>(
                    title: const Text('Claro'),
                    value: ThemeMode.light,
                    groupValue: themeManager.themeMode,
                    onChanged: (val) => themeManager.setThemeMode(val!),
                  ),
                  RadioListTile<ThemeMode>(
                    title: const Text('Oscuro'),
                    value: ThemeMode.dark,
                    groupValue: themeManager.themeMode,
                    onChanged: (val) => themeManager.setThemeMode(val!),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Color Principal:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: [
                      _buildColorOption(ColoresApp.primario),
                      _buildColorOption(Colors.purple),
                      _buildColorOption(Colors.green),
                      _buildColorOption(Colors.red),
                      _buildColorOption(Colors.teal),
                    ],
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildColorOption(Color color) {
    final themeManager = ThemeManager();
    final isSelected = themeManager.primaryColor.value == color.value;
    return GestureDetector(
      onTap: () => themeManager.setPrimaryColor(color),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: isSelected ? Border.all(color: Colors.white, width: 3) : null,
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 4,
                spreadRadius: 1,
              ),
          ],
        ),
        child: isSelected
            ? const Icon(Icons.check, color: Colors.white, size: 20)
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Logo(),
        centerTitle: true,
        // Remove fixed backgroundColor to allow theme adoption, or update to use current theme primary
        // backgroundColor: ColoresApp.primario,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_brightness),
            onPressed: _mostrarAjustesTema,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const Text(
                    'Filtros: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 8),
                  DropdownButton<CategoriaTarea?>(
                    value: _filtroCategoria,
                    hint: const Text('Categoría'),
                    onChanged: (CategoriaTarea? value) {
                      setState(() {
                        _filtroCategoria = value;
                      });
                    },
                    items: [
                      const DropdownMenuItem(
                        value: null,
                        child: Text('Todas las categorías'),
                      ),
                      ...CategoriaTarea.values.map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.nombreCapitalizado),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  DropdownButton<bool?>(
                    value: _filtroCompletado,
                    hint: const Text('Estado'),
                    onChanged: (bool? value) {
                      setState(() {
                        _filtroCompletado = value;
                      });
                    },
                    items: const [
                      DropdownMenuItem(
                        value: null,
                        child: Text('Todos los estados'),
                      ),
                      DropdownMenuItem(value: false, child: Text('Pendientes')),
                      DropdownMenuItem(value: true, child: Text('Completadas')),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: _tareasFiltradas.isEmpty
                ? SinTareas()
                : _filtrosActivos
                ? ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: _tareasFiltradas.length,
                    itemBuilder: (context, index) {
                      final tarea = _tareasFiltradas[index];
                      return Dismissible(
                        key: Key(tarea.id),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20.0),
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: ColoresApp.error,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (direction) {
                          _borrarTarea(tarea);
                        },
                        child: TarjetaTarea(
                          tarea: tarea,
                          onEliminar: () => _borrarTarea(tarea),
                          onCambiarEstado: () => _cambiarEstadoTarea(tarea),
                          onTap: () => _editarTarea(tarea),
                        ),
                      );
                    },
                  )
                : ReorderableListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: _tareasFiltradas.length,
                    onReorder: _reordenarTareas,
                    buildDefaultDragHandles: false,
                    itemBuilder: (context, index) {
                      final tarea = _tareasFiltradas[index];
                      return Dismissible(
                        key: Key(tarea.id),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20.0),
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: ColoresApp.error,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (direction) {
                          _borrarTarea(tarea);
                        },
                        child: TarjetaTarea(
                          tarea: tarea,
                          onEliminar: () => _borrarTarea(tarea),
                          onCambiarEstado: () => _cambiarEstadoTarea(tarea),
                          onTap: () => _editarTarea(tarea),
                          trailingWidget: ReorderableDragStartListener(
                            index: index,
                            child: const Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Icon(
                                Icons.drag_handle,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
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
