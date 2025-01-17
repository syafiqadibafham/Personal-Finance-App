import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    surface: Color.fromARGB(255, 255, 255, 255),
    primary: Color.fromARGB(255, 173, 125, 102),
    secondary: Color.fromARGB(255, 160, 146, 149),
    tertiary: Color.fromARGB(255, 160, 146, 149),
    inversePrimary: Color.fromARGB(255, 197, 218, 218),
  ),
  scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
  textTheme: const TextTheme().copyWith(
    bodySmall: const TextStyle(color: Color.fromARGB(255, 75, 76, 81)),
    bodyMedium: const TextStyle(color: Color.fromARGB(255, 75, 76, 81)),
    bodyLarge: const TextStyle(color: Color.fromARGB(255, 75, 76, 81)),
    labelSmall: const TextStyle(color: Color.fromARGB(255, 75, 76, 81)),
    labelMedium: const TextStyle(color: Color.fromARGB(255, 75, 76, 81)),
    labelLarge: const TextStyle(color: Color.fromARGB(255, 75, 76, 81)),
    displaySmall: const TextStyle(color: Color.fromARGB(255, 75, 76, 81)),
    displayMedium: const TextStyle(color: Color.fromARGB(255, 75, 76, 81)),
    displayLarge: const TextStyle(color: Color.fromARGB(255, 75, 76, 81)),
  ),
);
