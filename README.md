# Mis entregas

Mis entregas es una app de Flutter para apuntar y controlar las entregas (tareas) del instituto: qué hay que hacer, de qué asignatura es, para cuándo y si ya está hecha. La hicimos Jamie y Tamayo para la actividad «Herramientas externas» de Desarrollo de Interfaces (2.º DAM), con el editor visual Nowa y cuatro cambios hechos a mano en el código Dart.

## Qué hace
- Muestra una lista de tareas con la imagen de su asignatura, el título y la fecha.
- Enseña el progreso arriba («1 de 4 entregas hechas») con una barra.
- Tiene un buscador por título y un interruptor «Ocultar las hechas» que filtra la lista.
- Al tocar una tarea se abre su detalle, donde se puede marcarla como hecha (con un mensaje de confirmación) o eliminarla.
- También se puede borrar deslizando la tarjeta hacia la izquierda, con la opción de deshacer.
- La pantalla «Nueva tarea» tiene un formulario con título (obligatorio, con aviso si falta), asignatura, fecha límite y descripción.
- Las tareas se guardan en formato JSON y siguen ahí al cerrar y abrir la app.
- Se adapta a pantallas desde 320 píxeles de ancho hasta pantallas grandes.

## Cómo ejecutarla
Versión web, sin instalar nada: https://skullbyte.github.io/Mis-Entregas/

En el ordenador:
1. Instalar Flutter.
2. `flutter pub get`
3. `flutter run -d linux` (o `windows`, `macos`, `chrome` según el sistema)

Para generar la versión de escritorio final: `flutter build linux --release`.

## Estructura
- `lib/main.dart`: arranque de la app.
- `lib/pages/`: las tres pantallas (`home_page.dart`, `detalle_page.dart` y `anadir_page.dart`).
- `lib/models/tarea.dart`: la clase Tarea y las asignaturas, con la conversión a JSON.
- `lib/globals/`: el estado de las tareas y su guardado (`tareas_state.dart`), las rutas (`router.dart`) y el tema (`themes.dart`).
- `assets/img/`: las imágenes de cada asignatura.
- `boards/first.board`: el lienzo de Nowa con las tres pantallas.

## Tecnologías
Flutter y Dart, Nowa (editor visual), go_router (navegación), provider (tema), shared_preferences (guardado) y flutter_localizations (textos en español).

## Modificaciones hechas a mano en Dart
| Quién | Tipo | Qué cambia | Archivo y líneas |
|---|---|---|---|
| Jamie | Visual | Color y bordes redondeados de las tarjetas | `lib/pages/home_page.dart`, 126-127 |
| Jamie | Funcional | Mensaje al marcar una tarea como hecha | `lib/pages/detalle_page.dart`, 73-84 |
| Tamayo | Visual | Título del detalle en tamaño 28 y negrita | `lib/pages/detalle_page.dart`, 44 |
| Tamayo | Funcional | El interruptor «Ocultar las hechas» filtra la lista | `lib/pages/home_page.dart`, 249-251 |

El código de antes y de después de cada una se puede ver en el historial de commits del repositorio.

## Autores
Jamie Tanner Rodríguez y Tamayo.

