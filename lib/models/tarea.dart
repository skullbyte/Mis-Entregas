import 'package:flutter/material.dart';

/// Una asignatura del ciclo: su código corto, nombre, imagen y color.
class Asignatura {
  const Asignatura(this.codigo, this.nombre, this.imagen, this.color);

  final String codigo;
  final String nombre;
  final String imagen;
  final Color color;
}

const asignaturas = [
  Asignatura(
    'DI',
    'Desarrollo de Interfaces',
    'assets/img/di.png',
    Color(0xFF3E7C82),
  ),
  Asignatura(
    'SGE',
    'Sistemas de Gestión Empresarial',
    'assets/img/sge.png',
    Color(0xFF8E6A9E),
  ),
  Asignatura(
    'IPE',
    'Itinerario para la Empleabilidad',
    'assets/img/ipe.png',
    Color(0xFFD4775A),
  ),
  Asignatura(
    'OTRA',
    'Otra asignatura',
    'assets/img/otra.png',
    Color(0xFFB88A1E),
  ),
];

Asignatura asignaturaDe(String codigo) => asignaturas.firstWhere(
  (a) => a.codigo == codigo,
  orElse: () => asignaturas.last,
);

String formatoFecha(DateTime f) =>
    '${f.day.toString().padLeft(2, '0')}/${f.month.toString().padLeft(2, '0')}/${f.year}';

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
  final DateTime fecha;
  final String descripcion;
  bool hecha;

  String get fechaTexto => formatoFecha(fecha);

  Map<String, dynamic> toJson() => {
    'id': id,
    'titulo': titulo,
    'asignatura': asignatura,
    'fecha': fecha.toIso8601String(),
    'descripcion': descripcion,
    'hecha': hecha,
  };

  factory Tarea.fromJson(Map<String, dynamic> json) => Tarea(
    id: json['id'] as int,
    titulo: json['titulo'] as String,
    asignatura: json['asignatura'] as String,
    fecha: DateTime.parse(json['fecha'] as String),
    descripcion: json['descripcion'] as String? ?? '',
    hecha: json['hecha'] as bool? ?? false,
  );
}
