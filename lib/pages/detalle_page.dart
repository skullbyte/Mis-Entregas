import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:mis_entregas/globals/tareas_state.dart';
import 'package:mis_entregas/models/tarea.dart';

@NowaGenerated()
class DetallePage extends StatelessWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const DetallePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: tareasState,
      builder: (context, _) {
        final t = tareasState.seleccionada ?? tareasState.tareas.first;
        final a = asignaturaDe(t.asignatura);
        return Scaffold(
          appBar: AppBar(title: const Text('Detalle')),
          body: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 640),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              a.imagen,
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            t.titulo,
                            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 12),
                          _Datos(tarea: t),
                          const SizedBox(height: 16),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                t.descripcion.isEmpty
                                    ? 'Sin descripción.'
                                    : t.descripcion,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: FilledButton.icon(
                            style: FilledButton.styleFrom(
                              backgroundColor: t.hecha ? Colors.green : null,
                              minimumSize: const Size.fromHeight(52),
                            ),
                            onPressed: () {
                              tareasState.alternarHecha(t);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    t.hecha
                                        ? 'Tarea marcada como hecha'
                                        : 'Tarea marcada como pendiente',
                                  ),
                                ),
                              );
                            },
                            icon: Icon(t.hecha ? Icons.undo : Icons.check),
                            label: Text(
                              t.hecha
                                  ? 'Hecha (pulsa para deshacer)'
                                  : 'Marcar como hecha',
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        IconButton.outlined(
                          tooltip: 'Eliminar',
                          onPressed: () {
                            tareasState.eliminar(t);
                            context.pop();
                          },
                          icon: const Icon(Icons.delete_outline),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Asignatura, fecha y estado de la tarea en forma de chips.
class _Datos extends StatelessWidget {
  const _Datos({required this.tarea});

  final Tarea tarea;

  @override
  Widget build(BuildContext context) {
    final a = asignaturaDe(tarea.asignatura);
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        Chip(avatar: const Icon(Icons.school, size: 18), label: Text(a.nombre)),
        Chip(
          avatar: const Icon(Icons.event, size: 18),
          label: Text(tarea.fechaTexto),
        ),
        Chip(
          avatar: Icon(
            tarea.hecha ? Icons.check_circle : Icons.schedule,
            size: 18,
          ),
          label: Text(tarea.hecha ? 'Hecha' : 'Pendiente'),
          backgroundColor: tarea.hecha
              ? Colors.green.shade100
              : Colors.amber.shade100,
        ),
      ],
    );
  }
}
