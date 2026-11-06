import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';

@NowaGenerated()
final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3E7C82)),
  scaffoldBackgroundColor: const Color(0xFFF6F5F2),
  appBarTheme: const AppBarTheme(
    centerTitle: false,
    backgroundColor: Color(0xFFF6F5F2),
    titleTextStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Color(0xFF1E1C1A)),
  ),
  textTheme: const TextTheme(),
);

@NowaGenerated()
final ThemeData darkTheme = ThemeData(
  colorScheme: const ColorScheme.dark(),
  textTheme: const TextTheme(),
);
