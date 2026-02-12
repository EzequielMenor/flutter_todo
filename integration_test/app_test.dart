import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:material/main.dart' as app;

/// Pruebas de integración para la aplicación completa.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('E2E App Tests', () {
    /// Prueba el flujo de agregar una nueva tarea.
    testWidgets('Flujo completo: Ver lista, agregar tarea y verificar', (
      tester,
    ) async {
      app.main();
      await tester.pumpAndSettle();

      // Validar estado inicial (puede haber tareas de ejemplo o no)
      // Asumimos que carga la pagina principal
      expect(find.text('Mis Tareas'), findsOneWidget);

      // Navegar a agregar tarea
      final fab = find.byType(FloatingActionButton);
      expect(fab, findsOneWidget);
      await tester.tap(fab);
      await tester.pumpAndSettle();

      // Llenar formulario
      await tester.enterText(
        find.widgetWithText(TextField, 'Nombre de la tarea'),
        'Tarea E2E',
      );

      // Guardar
      await tester.tap(find.text('Agregar'));
      await tester.pumpAndSettle();

      // Verificar que volvimos y la tarea está en la lista
      expect(find.text('Mis Tareas'), findsOneWidget);
      expect(find.text('Tarea E2E'), findsOneWidget);
    });
  });
}
