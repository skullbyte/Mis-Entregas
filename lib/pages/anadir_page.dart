import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:mis_entregas/globals/tareas_state.dart';

@NowaGenerated()
class AnadirPage extends StatelessWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const AnadirPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Añadir tarea')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              onChanged: tareasState.setBorrador,
              decoration: const InputDecoration(
                labelText: 'Título de la tarea',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ListenableBuilder(
              listenable: tareasState,
              builder: (context, _) => SwitchListTile(
                title: const Text('Ocultar las hechas'),
                value: tareasState.ocultarHechas,
                onChanged: tareasState.setOcultarHechas,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  final texto = tareasState.borrador.trim();
                  if (texto.isEmpty) return;
                  tareasState.anadir(texto);
                  tareasState.setBorrador('');
                  context.pop();
                },
                child: const Text('Guardar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
