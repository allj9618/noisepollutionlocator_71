import 'package:flutter/material.dart';
import 'package:noisepollutionlocator_71/themes.dart';
import 'bottom_navigation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      home: OurNavigationBar(),
    );
  }
}