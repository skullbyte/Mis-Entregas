import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:mis_entregas/globals/tareas_state.dart';

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
        return Scaffold(
          appBar: AppBar(title: const Text('Detalle')),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  t.hecha ? Icons.check_circle : Icons.assignment,
                  size: 96,
                  color: t.hecha ? Colors.green : Colors.grey,
                ),
                const SizedBox(height: 16),
                Text(
                  t.titulo,
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text('${t.asignatura} · ${t.fecha}'),
                const SizedBox(height: 16),
                Text(t.descripcion.isEmpty ? 'Sin descripción.' : t.descripcion),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: t.hecha ? Colors.green : null,
                    ),
                    onPressed: () => tareasState.alternarHecha(t),
                    icon: Icon(t.hecha ? Icons.undo : Icons.check),
                    label: Text(t.hecha ? 'Hecha (pulsa para deshacer)' : 'Marcar como hecha'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
