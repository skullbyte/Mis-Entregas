import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:mis_entregas/globals/tareas_state.dart';
import 'package:mis_entregas/models/tarea.dart';

@NowaGenerated()
class HomePage extends StatelessWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mis entregas')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/anadir'),
        icon: const Icon(Icons.add),
        label: const Text('Nueva tarea'),
      ),
      body: ListenableBuilder(
        listenable: tareasState,
        builder: (context, _) {
          final tareas = tareasState.ocultarHechas
              ? tareasState.conBusqueda.where((t) => !t.hecha).toList()
              : tareasState.conBusqueda;
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 640),
              child: Column(
                children: [
                  _Resumen(
                    hechas: tareasState.hechas,
                    total: tareasState.tareas.length,
                  ),
                  _Filtros(ocultar: tareasState.ocultarHechas),
                  Expanded(
                    child: tareas.isEmpty
                        ? const _Vacio()
                        : ListView.builder(
                            padding: const EdgeInsets.fromLTRB(16, 4, 16, 96),
                            itemCount: tareas.length,
                            itemBuilder: (context, i) =>
                                _TareaCard(tarea: tareas[i]),
                          ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Tarjeta de arriba: cuántas tareas están hechas y una barra de progreso.
class _Resumen extends StatelessWidget {
  const _Resumen({required this.hechas, required this.total});

  final int hechas;
  final int total;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [color.primary, color.tertiary]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$hechas de $total entregas hechas',
            style: TextStyle(
              color: color.onPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: total == 0 ? 0 : hechas / total,
              minHeight: 10,
              backgroundColor: Colors.white24,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

/// Buscador por título e interruptor para ocultar las tareas hechas.
class _Filtros extends StatelessWidget {
  const _Filtros({required this.ocultar});

  final bool ocultar;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          TextField(
            onChanged: tareasState.setBusqueda,
            decoration: InputDecoration(
              hintText: 'Buscar tarea',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Ocultar las hechas'),
            value: ocultar,
            onChanged: tareasState.setOcultarHechas,
          ),
        ],
      ),
    );
  }
}

class _TareaCard extends StatelessWidget {
  const _TareaCard({required this.tarea});

  final Tarea tarea;

  @override
  Widget build(BuildContext context) {
    final a = asignaturaDe(tarea.asignatura);
    return Dismissible(
      key: ValueKey(tarea.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) {
        final posicion = tareasState.eliminar(tarea);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Tarea eliminada'),
            action: SnackBarAction(
              label: 'Deshacer',
              onPressed: () => tareasState.restaurar(tarea, posicion),
            ),
          ),
        );
      },
      child: Card(
        color: Colors.orange.shade50,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            tareasState.seleccionar(tarea);
            context.push('/detalle');
          },
          child: Row(
            children: [
              Image.asset(a.imagen, width: 92, height: 92, fit: BoxFit.cover),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tarea.titulo,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          decoration: tarea.hecha
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          _Etiqueta(texto: a.codigo, color: a.color),
                          const SizedBox(width: 8),
                          const Icon(Icons.event, size: 16),
                          const SizedBox(width: 4),
                          Text(tarea.fechaTexto),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 14),
                child: Icon(
                  tarea.hecha
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked,
                  color: tarea.hecha ? Colors.green : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Etiqueta extends StatelessWidget {
  const _Etiqueta({required this.texto, required this.color});

  final String texto;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        texto,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
    );
  }
}

class _Vacio extends StatelessWidget {
  const _Vacio();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.inbox_outlined, size: 64, color: Colors.grey),
          SizedBox(height: 8),
          Text('No hay tareas que mostrar'),
        ],
      ),
    );
  }
}
