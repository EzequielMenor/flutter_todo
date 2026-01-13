import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import 'package:material/core/colores_app.dart';
import 'package:material/models/tarea.dart';

class TarjetaTarea extends StatelessWidget {
  const TarjetaTarea({
    super.key,
    required this.tarea,
    required this.onEliminar,
    required this.onCambiarEstado,
    this.onTap,
  });

  final Tarea tarea;
  final VoidCallback onEliminar;
  final VoidCallback onCambiarEstado;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        onTap: onTap,
        leading: AnimatedSwitcher(
          duration: Duration(milliseconds: 250),
          child: Checkbox(
            key: ValueKey<bool>(tarea.completado),
            value: tarea.completado,
            onChanged: (inx) => onCambiarEstado(),
            activeColor: ColoresApp.secundario,
            checkColor: ColoresApp.surface2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        title: Row(
          children: [
            Icon(
              Icons.task,
              color: tarea.completado
                  ? ColoresApp.completed
                  : ColoresApp.foregraund,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                tarea.nombre,
                style: TextStyle(
                  decoration: tarea.completado
                      ? TextDecoration.lineThrough
                      : null,
                  color: tarea.completado
                      ? ColoresApp.completed
                      : ColoresApp.foregraund,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        subtitle: tarea.descripcion.isEmpty
            ? null
            : Row(
                children: [
                  const Icon(
                    Icons.description_outlined,
                    color: ColoresApp.completed,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      tarea.descripcion,
                      style: TextStyle(
                        color: ColoresApp.completed,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
        trailing: IconButton(
          onPressed: onEliminar,
          icon: Icon(Icons.delete_forever, color: ColoresApp.error),
        ),
      ),
    );
  }
}
