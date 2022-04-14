import 'package:flutter/material.dart';

class ThemeChoice {
  ThemeChoice();

  static final ThemeData darkMode = ThemeData(
    primarySwatch: Colors.purple,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0.0,
    ),
    brightness: Brightness.dark,
    primaryColor: Colors.amber,
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.amber,
      disabledColor: Colors.black,
    ),
  );
  static final ThemeData lightMode = ThemeData(
    primarySwatch: Colors.pink,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.purple,
      centerTitle: true,
      elevation: 0.0,
    ),
    brightness: Brightness.light,
    primaryColor: Colors.orange,
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.pinkAccent,
      disabledColor: Colors.white,
    ),
  );
}
