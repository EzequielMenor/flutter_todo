class Tarea {
  Tarea({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.completado,
  });

  String id;
  String nombre;
  String descripcion;
  bool completado;
}

class EjemploTareaCompletada extends Tarea {
  EjemploTareaCompletada()
    : super(
        id: 't-1',
        nombre: 'Tarea Completada de Ejemplo',
        descripcion: 'Esta es una descripción de una tarea finalizada.',
        completado: true,
      );
}

class EjemploTareaPendiente extends Tarea {
  EjemploTareaPendiente()
    : super(
        id: 't-2',
        nombre: 'Tarea Pendiente de Ejemplo',
        descripcion: 'Esta es una descripción de una tarea pendiente.',
        completado: false,
      );
}
