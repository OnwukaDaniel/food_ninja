import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      color: Colors.transparent,
      iconTheme: IconThemeData(color: Color.fromARGB(255, 0, 0, 0)),
    ),
    dividerColor: Colors.grey,
    useMaterial3: true,
    backgroundColor: const Color(0xfff8fcfa),
    cardColor: Colors.white,
    cardTheme: const CardTheme(color: Colors.white60),
    primaryColor: const Color.fromARGB(255, 255, 255, 255),
    textTheme: const TextTheme(
      bodyText1: TextStyle(color: Colors.black),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      color: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    dividerColor: Colors.white,
    useMaterial3: true,
    backgroundColor: Colors.black87,
    cardColor: const Color(0xff444343),
    cardTheme: const CardTheme(color: Color(0xff444343)),
    primaryColor: const Color.fromARGB(255, 255, 255, 255),
    textTheme: const TextTheme(bodyText1: TextStyle(color: Colors.white)),
    dividerTheme: const DividerThemeData(color: Colors.grey),
  );
}
