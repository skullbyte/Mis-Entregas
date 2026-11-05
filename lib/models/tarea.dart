class Tarea {
  Tarea({
    required this.id,
    required this.titulo,
    required this.asignatura,
    required this.fecha,
    this.descripcion = '',
    this.hecha = false,
  });

  final int id;
  final String titulo;
  final String asignatura;
  final String fecha;
  final String descripcion;
  bool hecha;
}
