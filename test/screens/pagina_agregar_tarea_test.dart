import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material/models/tarea.dart';
import 'package:material/screens/pagina_agregar_tarea.dart';

/// Pruebas de widget para [PaginaAgregarTarea].
void main() {
  group('PaginaAgregarTarea Widget Tests', () {
    /// Verifica que los elementos UI esenciales estén presentes.
    testWidgets('Debe renderizar los campos de texto y botón correctamente', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: PaginaAgregarTarea()));

      expect(find.text('Nombre de la tarea'), findsWidgets); // Label y Hint
      expect(find.text('Descripción'), findsOneWidget); // Label
      expect(find.text('Categoría'), findsOneWidget);
      expect(find.text('Agregar'), findsOneWidget);
    });

    testWidgets('Debe mostrar error o no cerrar si el nombre está vacío', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: PaginaAgregarTarea()));

      await tester.tap(find.text('Agregar'));
      await tester.pump();

      // Verifica que seguimos en la misma página (no se ha cerrado)
      expect(find.byType(PaginaAgregarTarea), findsOneWidget);
    });

    testWidgets('Debe retornar una Tarea al guardar con datos válidos', (
      WidgetTester tester,
    ) async {
      TaskResult? result;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () async {
                  final tarea = await Navigator.push<Tarea>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PaginaAgregarTarea(),
                    ),
                  );
                  result = TaskResult(tarea);
                },
                child: const Text('Lanzar'),
              );
            },
          ),
        ),
      );

      // Abrir página
      await tester.tap(find.text('Lanzar'));
      await tester.pumpAndSettle();

      // Llenar datos
      await tester.enterText(
        find.widgetWithText(TextField, 'Nombre de la tarea'),
        'Nueva Tarea',
      );
      await tester.enterText(
        find.widgetWithText(TextField, 'Descripción'),
        'Descripción test',
      );

      // Seleccionar categoría (opcional, por defecto es personal) -> Probamos cambiarlo
      await tester.tap(find.byType(DropdownButtonFormField<CategoriaTarea>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Trabajo').last);
      await tester.pumpAndSettle();

      // Guardar
      await tester.tap(find.text('Agregar'));
      await tester.pumpAndSettle();

      expect(result?.tarea, isNotNull);
      expect(result?.tarea?.nombre, 'Nueva Tarea');
      expect(result?.tarea?.categoria, CategoriaTarea.trabajo);
    });
  });
}

// Clase auxiliar para capturar el resultado
class TaskResult {
  final Tarea? tarea;
  TaskResult(this.tarea);
}
