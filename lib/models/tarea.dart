/// Categorías disponibles para clasificar una tarea.
enum CategoriaTarea {
  /// Tareas personales.
  personal,

  /// Tareas relacionadas con el trabajo.
  trabajo,

  /// Otras categorías.
  otro;

  String get nombreCapitalizado {
    switch (this) {
      case CategoriaTarea.personal:
        return 'Personal';
      case CategoriaTarea.trabajo:
        return 'Trabajo';
      case CategoriaTarea.otro:
        return 'Otro';
    }
  }
}

/// Modelo que representa una tarea en la lista.
class Tarea {
  /// Constructor de la clase [Tarea].
  Tarea({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.completado,
    this.categoria = CategoriaTarea.personal,
  });

  /// Identificador único de la tarea.
  String id;

  /// Nombre o título de la tarea.
  String nombre;

  /// Descripción detallada de la tarea.
  String descripcion;

  /// Estado de finalización de la tarea.
  bool completado;

  /// Categoría a la que pertenece la tarea.
  CategoriaTarea categoria;
}

class EjemploTareaCompletada extends Tarea {
  EjemploTareaCompletada()
    : super(
        id: 't-1',
        nombre: 'Tarea Completada de Ejemplo',
        descripcion: 'Esta es una descripción de una tarea finalizada.',
        completado: true,
        categoria: CategoriaTarea.trabajo,
      );
}

class EjemploTareaPendiente extends Tarea {
  EjemploTareaPendiente()
    : super(
        id: 't-2',
        nombre: 'Tarea Pendiente de Ejemplo',
        descripcion: 'Esta es una descripción de una tarea pendiente.',
        completado: false,
        categoria: CategoriaTarea.personal,
      );
}
