import 'package:flutter/material.dart';
import 'package:mis_entregas/models/tarea.dart';

/// Estado compartido de las tareas. Avisa a las pantallas cuando cambia.
class TareasState extends ChangeNotifier {
  final List<Tarea> tareas = [
    Tarea(
      id: 1,
      titulo: 'Proyecto Flutter con Nowa',
      asignatura: 'Desarrollo de Interfaces',
      fecha: '12/11/2026',
      descripcion: 'App de 3 pantallas hecha con un editor visual y 2 cambios a mano en Dart.',
    ),
    Tarea(
      id: 2,
      titulo: 'Hola Mundo en Odoo',
      asignatura: 'Sistemas de Gestión Empresarial',
      fecha: '11/11/2026',
      descripcion: 'Crear un módulo mínimo en Odoo que se instale y se vea en el menú.',
    ),
    Tarea(
      id: 3,
      titulo: 'Exposición IPE RA2',
      asignatura: 'Itinerario Personal para la Empleabilidad',
      fecha: '20/11/2026',
      descripcion: 'Preparar la presentación oral del resultado de aprendizaje 2.',
    ),
  ];

  bool ocultarHechas = false;
  Tarea? seleccionada;
  String borrador = '';

  void seleccionar(Tarea tarea) => seleccionada = tarea;

  void setBorrador(String texto) => borrador = texto;

  void anadir(String titulo) {
    final id = tareas.isEmpty ? 1 : tareas.last.id + 1;
    tareas.add(Tarea(id: id, titulo: titulo, asignatura: 'Sin asignatura', fecha: 'Sin fecha'));
    notifyListeners();
  }

  void alternarHecha(Tarea tarea) {
    tarea.hecha = !tarea.hecha;
    notifyListeners();
  }

  void setOcultarHechas(bool valor) {
    ocultarHechas = valor;
    notifyListeners();
  }
}

final tareasState = TareasState();
