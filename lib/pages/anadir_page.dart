import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:mis_entregas/globals/tareas_state.dart';
import 'package:mis_entregas/models/tarea.dart';

@NowaGenerated()
class AnadirPage extends StatefulWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const AnadirPage({super.key});

  @override
  State<AnadirPage> createState() {
    return _AnadirPageState();
  }
}

@NowaGenerated()
class _AnadirPageState extends State<AnadirPage> {
  final _formulario = GlobalKey<FormState>();
  final _titulo = TextEditingController();
  final _descripcion = TextEditingController();
  String _asignatura = 'DI';
  DateTime _fecha = DateTime.now().add(const Duration(days: 7));

  @override
  void dispose() {
    _titulo.dispose();
    _descripcion.dispose();
    super.dispose();
  }

  Future<void> _elegirFecha() async {
    final elegida = await showDatePicker(
      context: context,
      initialDate: _fecha,
      firstDate: DateTime(2026),
      lastDate: DateTime(2030),
    );
    if (elegida != null) setState(() => _fecha = elegida);
  }

  void _guardar() {
    if (!_formulario.currentState!.validate()) return;
    tareasState.anadir(
      titulo: _titulo.text.trim(),
      asignatura: _asignatura,
      fecha: _fecha,
      descripcion: _descripcion.text.trim(),
    );
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final fechaTexto = formatoFecha(_fecha);
    return Scaffold(
      appBar: AppBar(title: const Text('Nueva tarea')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: Form(
            key: _formulario,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                TextFormField(
                  controller: _titulo,
                  decoration: const InputDecoration(
                    labelText: 'Título de la tarea',
                    prefixIcon: Icon(Icons.edit_outlined),
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? 'Escribe un título'
                      : null,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: _asignatura,
                  decoration: const InputDecoration(
                    labelText: 'Asignatura',
                    prefixIcon: Icon(Icons.school_outlined),
                    border: OutlineInputBorder(),
                  ),
                  items: [
                    for (final a in asignaturas)
                      DropdownMenuItem(value: a.codigo, child: Text(a.nombre)),
                  ],
                  onChanged: (v) => setState(() => _asignatura = v!),
                ),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(56),
                  ),
                  onPressed: _elegirFecha,
                  icon: const Icon(Icons.event),
                  label: Text('Fecha límite: $fechaTexto'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descripcion,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Descripción (opcional)',
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(52),
                  ),
                  onPressed: _guardar,
                  icon: const Icon(Icons.save_outlined),
                  label: const Text('Guardar tarea'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
