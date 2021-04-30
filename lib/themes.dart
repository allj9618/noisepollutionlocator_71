import 'package:flutter/material.dart';

class Themes {
  static final lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      primaryColor: Colors.white,
      accentColor: Colors.black,
      focusColor: Colors.grey,
      colorScheme: ColorScheme.light(),
      textTheme: TextTheme(
        bodyText1: TextStyle(),
        bodyText2: TextStyle(),
      ).apply(
        bodyColor: Colors.grey,
        //displayColor: Colors.blue,
      ),
  );

  static final darkTheme = ThemeData(
      scaffoldBackgroundColor: Colors.grey.shade900,
      primaryColor: Colors.grey.shade900,
      accentColor: Colors.white,
      colorScheme: ColorScheme.dark(),
      textTheme: TextTheme(
        bodyText1: TextStyle(),
        bodyText2: TextStyle(),
      ).apply(
        bodyColor: Colors.amber.shade900,
        //displayColor: Colors.blue,
    ),
  );
}