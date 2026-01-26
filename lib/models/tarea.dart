enum CategoriaTarea {
  personal,
  trabajo,
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

class Tarea {
  Tarea({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.completado,
    this.categoria = CategoriaTarea.personal,
  });

  String id;
  String nombre;
  String descripcion;
  bool completado;
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
