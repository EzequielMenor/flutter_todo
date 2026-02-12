import 'package:flutter/material.dart';

import 'package:material/core/colores_app.dart';
import 'package:material/models/tarea.dart';

/// Widget que representa una tarjeta individual de tarea en la lista.
class TarjetaTarea extends StatelessWidget {
  /// La tarea a mostrar.
  final Tarea tarea;

  /// Callback al eliminar la tarea.
  final VoidCallback onEliminar;

  /// Callback al cambiar el estado del checkbox.
  final Function(bool?) onCambiarEstado;

  /// Callback al tocar la tarjeta.
  final VoidCallback? onTap;

  /// Widget opcional para mostrar al final de la tarjeta.
  final Widget? trailingWidget;

  /// Constructor del widget.
  /// Constructor del widget.
  const TarjetaTarea({
    super.key,
    required this.tarea,
    required this.onEliminar,
    required this.onCambiarEstado,
    this.onTap,
    this.trailingWidget,
  });

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
            onChanged: (inx) => onCambiarEstado(inx),
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
                  : Theme.of(context).colorScheme.onSurface,
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
                      : Theme.of(context).colorScheme.onSurface,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (tarea.descripcion.isNotEmpty) ...[
              Row(
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
                      style: const TextStyle(
                        color: ColoresApp.completed,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                tarea.categoria.nombreCapitalizado,
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!tarea.completado)
              IconButton(
                onPressed: onTap,
                icon: Icon(Icons.edit, color: Theme.of(context).primaryColor),
              ),
            IconButton(
              onPressed: onEliminar,
              icon: Icon(Icons.delete_forever, color: ColoresApp.error),
            ),
            if (trailingWidget != null) trailingWidget!,
          ],
        ),
      ),
    );
  }
}
