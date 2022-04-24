import 'package:flutter/material.dart';

class ThemeChoice {
  ThemeChoice();

  static final ThemeData darkMode = ThemeData(
    primarySwatch: Colors.purple,
    appBarTheme: const AppBarTheme(
      elevation: 0.0,
    ),
    brightness: Brightness.dark,
    primaryColor: Colors.amber,
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.amber,
      disabledColor: Colors.black,
    ),
    tabBarTheme: TabBarTheme(labelColor: Colors.white),
  );
  static final ThemeData lightMode = ThemeData(
    primarySwatch: Colors.pink,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.purple,
      elevation: 0.0,
    ),
    brightness: Brightness.light,
    primaryColor: Colors.orange,
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.pinkAccent,
      disabledColor: Colors.white,
    ),
    tabBarTheme: const TabBarTheme(
      labelColor: Colors.white,
    ),
  );
}
