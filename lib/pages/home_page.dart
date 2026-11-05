import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:mis_entregas/globals/tareas_state.dart';

@NowaGenerated()
class HomePage extends StatelessWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mis entregas')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/anadir'),
        child: const Icon(Icons.add),
      ),
      body: ListenableBuilder(
        listenable: tareasState,
        builder: (context, _) {
          final tareas = tareasState.tareas;
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: tareas.length,
            itemBuilder: (context, i) {
              final t = tareas[i];
              return Card(
                child: ListTile(
                  leading: Icon(t.hecha ? Icons.check_circle : Icons.assignment),
                  title: Text(t.titulo),
                  subtitle: Text('${t.asignatura} · ${t.fecha}'),
                  onTap: () {
                    tareasState.seleccionar(t);
                    context.push('/detalle');
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
