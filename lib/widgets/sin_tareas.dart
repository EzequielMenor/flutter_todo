import 'package:flutter/material.dart';
import 'package:material/core/colores_app.dart';

class SinTareas extends StatelessWidget {
  const SinTareas({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.task_alt, color: ColoresApp.secundario, size: 48),
          const SizedBox(height: 16),
          Text(
            '¡No hay ninguna tarea!',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: ColoresApp.foregraund,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
