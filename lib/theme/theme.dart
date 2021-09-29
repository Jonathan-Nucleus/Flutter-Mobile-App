import 'package:flutter/material.dart';

final darkMode = ThemeData(
  inputDecorationTheme: InputDecorationTheme(
    fillColor: Colors.grey[200],
    hintStyle: TextStyle(color: Colors.grey[800]),
    labelStyle: TextStyle(color: Colors.grey[300]),
  ),
  appBarTheme: AppBarTheme(
    color: Colors.grey[850],
    textTheme: TextTheme(
      headline6: TextStyle(color: Colors.grey[100]),
    ),
  ),
  cardTheme: CardTheme(
    color: Colors.grey[900],
    shadowColor: Colors.grey[100],
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(color: Colors.grey[100]),
    overline: TextStyle(color: Colors.grey[100]),
    button: TextStyle(color: Colors.grey[100]),
    subtitle1: TextStyle(color: Colors.grey[200]),
    subtitle2: TextStyle(color: Colors.grey[400]),
    bodyText2: TextStyle(color: Colors.grey[900]),
    headline1: TextStyle(color: Colors.grey[100]),
    headline3: TextStyle(color: Colors.grey[850]),
  ),
  scaffoldBackgroundColor: Colors.grey[850],
  backgroundColor: Colors.black45,
  buttonColor: Colors.grey[850],
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.grey[850],
    hoverColor: Colors.grey[800],
  ),
  iconTheme: IconThemeData(color: Colors.grey[100]),
  hoverColor: Colors.grey[800],
  dividerTheme: DividerThemeData(
    color: Colors.grey[100],
  ),
  indicatorColor: Colors.grey[900],
  accentColor: Colors.grey[850],
  dialogBackgroundColor: Colors.grey[900],
);
