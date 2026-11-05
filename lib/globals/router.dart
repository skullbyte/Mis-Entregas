import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:mis_entregas/pages/anadir_page.dart';
import 'package:mis_entregas/pages/detalle_page.dart';
import 'package:mis_entregas/pages/home_page.dart';

@NowaGenerated()
final GoRouter appRouter = GoRouter(
  initialLocation: '/home-page',
  routes: [
    GoRoute(
      path: '/home-page',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/detalle',
      builder: (context, state) =>
          const DetallePage(),
    ),
    GoRoute(
      path: '/anadir',
      builder: (context, state) => const AnadirPage(),
    ),
  ],
);
