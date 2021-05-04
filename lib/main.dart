import 'package:flutter/material.dart';
import 'package:noisepollutionlocator_71/themes.dart';
import 'package:provider/provider.dart';
import 'bottom_navigation.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

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
      home: AnimatedSplashScreen(
        duration: 2500,
        splash: 'assets/logogif2.gif',
        splashIconSize: 500,
        nextScreen: OurNavigationBar(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Colors.white
      )
    );
  },
  );
}