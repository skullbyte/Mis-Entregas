import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mis_entregas/models/tarea.dart';

/// Estado compartido de las tareas. Avisa a las pantallas cuando cambia y
/// guarda la lista en formato JSON con shared_preferences.
class TareasState extends ChangeNotifier {
  TareasState() {
    _cargar();
  }

  static const _clave = 'tareas';

  final List<Tarea> tareas = [
    Tarea(
      id: 1,
      titulo: 'Proyecto Flutter con Nowa',
      asignatura: 'DI',
      fecha: DateTime(2026, 11, 12),
      descripcion:
          'App de 3 pantallas hecha con un editor visual y 4 cambios a mano en Dart.',
    ),
    Tarea(
      id: 2,
      titulo: 'Hola Mundo en Odoo',
      asignatura: 'SGE',
      fecha: DateTime(2026, 11, 11),
      descripcion:
          'Crear un módulo mínimo en Odoo que se instale y se vea en el menú.',
    ),
    Tarea(
      id: 3,
      titulo: 'Exposición IPE RA2',
      asignatura: 'IPE',
      fecha: DateTime(2026, 11, 20),
      descripcion:
          'Preparar la presentación oral del resultado de aprendizaje 2.',
    ),
    Tarea(
      id: 4,
      titulo: 'Memoria del proyecto',
      asignatura: 'DI',
      fecha: DateTime(2026, 11, 13),
      descripcion:
          'Documento con la comparativa de herramientas y las capturas del antes y el después.',
    ),
  ];

  bool ocultarHechas = false;
  String busqueda = '';
  Tarea? seleccionada;

  int get hechas => tareas.where((t) => t.hecha).length;

  /// Tareas cuyo título contiene el texto de búsqueda.
  List<Tarea> get conBusqueda {
    final texto = busqueda.trim().toLowerCase();
    return tareas.where((t) => t.titulo.toLowerCase().contains(texto)).toList();
  }

  void seleccionar(Tarea tarea) => seleccionada = tarea;

  void anadir({
    required String titulo,
    required String asignatura,
    required DateTime fecha,
    String descripcion = '',
  }) {
    final id = tareas.isEmpty
        ? 1
        : tareas.map((t) => t.id).reduce((a, b) => a > b ? a : b) + 1;
    tareas.add(
      Tarea(
        id: id,
        titulo: titulo,
        asignatura: asignatura,
        fecha: fecha,
        descripcion: descripcion,
      ),
    );
    _cambio();
  }

  void alternarHecha(Tarea tarea) {
    tarea.hecha = !tarea.hecha;
    _cambio();
  }

  /// Quita la tarea y devuelve la posición que tenía, para poder deshacerlo.
  int eliminar(Tarea tarea) {
    final posicion = tareas.indexOf(tarea);
    tareas.remove(tarea);
    _cambio();
    return posicion;
  }

  void restaurar(Tarea tarea, int posicion) {
    tareas.insert(posicion.clamp(0, tareas.length), tarea);
    _cambio();
  }

  void setBusqueda(String texto) {
    busqueda = texto;
    notifyListeners();
  }

  void setOcultarHechas(bool valor) {
    ocultarHechas = valor;
    notifyListeners();
  }

  void _cambio() {
    notifyListeners();
    _guardar();
  }

  Future<void> _guardar() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _clave,
      jsonEncode(tareas.map((t) => t.toJson()).toList()),
    );
  }

  Future<void> _cargar() async {
    final prefs = await SharedPreferences.getInstance();
    final texto = prefs.getString(_clave);
    if (texto == null) return;
    final lista = jsonDecode(texto) as List<dynamic>;
    tareas
      ..clear()
      ..addAll(lista.map((e) => Tarea.fromJson(e as Map<String, dynamic>)));
    notifyListeners();
  }
}

final tareasState = TareasState();
