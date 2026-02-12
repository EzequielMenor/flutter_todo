import 'package:flutter_test/flutter_test.dart';
import 'package:material/models/tarea.dart';

/// Pruebas unitarias para el modelo [Tarea] y [CategoriaTarea].
void main() {
  /// Grupo de pruebas para [Tarea].
  group('Modelo Tarea Tests', () {
    /// Verifica que una [Tarea] se crea correctamente con sus propiedades.
    test('Debe crear una Tarea con valores correctos', () {
      final tarea = Tarea(
        id: '1',
        nombre: 'Prueba unitaria',
        descripcion: 'Descripción de prueba',
        completado: false,
        categoria: CategoriaTarea.trabajo,
      );

      expect(tarea.id, '1');
      expect(tarea.nombre, 'Prueba unitaria');
      expect(tarea.descripcion, 'Descripción de prueba');
      expect(tarea.completado, false);
      expect(tarea.categoria, CategoriaTarea.trabajo);
    });

    /// Verifica que [CategoriaTarea.nombreCapitalizado] retorna el string correcto.
    test(
      'CategoriaTarea.nombreCapitalizado debe retornar el texto correcto',
      () {
        expect(CategoriaTarea.personal.nombreCapitalizado, 'Personal');
        expect(CategoriaTarea.trabajo.nombreCapitalizado, 'Trabajo');
        expect(CategoriaTarea.otro.nombreCapitalizado, 'Otro');
      },
    );

    /// Verifica la creación de [EjemploTareaCompletada].
    test('EjemploTareaCompletada debe estar completada', () {
      final tarea = EjemploTareaCompletada();
      expect(tarea.completado, true);
      expect(tarea.categoria, CategoriaTarea.trabajo);
    });
  });
}
