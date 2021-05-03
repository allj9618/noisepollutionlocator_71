import 'package:flutter/material.dart';
import 'package:noisepollutionlocator_71/themes.dart';
import 'package:provider/provider.dart';
import 'bottom_navigation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    builder: (context, _) {
      final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      //title: 'Flutter Demo',
      themeMode: themeProvider.themeMode,
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      home: OurNavigationBar(),
    );
  },
  );
}