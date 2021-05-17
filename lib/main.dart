import 'package:flutter/material.dart';
import 'package:noisepollutionlocator_71/themes.dart';
import 'package:provider/provider.dart';
import 'bottom_navigation.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'translations.dart';
import 'translationApplication.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}
class _MyAppState extends State<MyApp>{
  SpecificLocalizationDelegate _localeOverrideDelegate;
  @override
  void initState(){
    super.initState();
    _localeOverrideDelegate = new SpecificLocalizationDelegate(null);
    applic.onLocaleChanged = onLocaleChange;
  }
  onLocaleChange(Locale locale){
    setState((){
      _localeOverrideDelegate = new SpecificLocalizationDelegate(locale);
    });
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    builder: (context, _) {
      final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      //title: AppLocalizations.of(context).helloWorld,
        localizationsDelegates: [
          _localeOverrideDelegate,
          const TranslationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          //GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: applic.supportedLocales(),
      themeMode: themeProvider.themeMode,
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      home: AnimatedSplashScreen(
        duration: 2500,
        splash: 'assets/logogif.gif',
        splashIconSize: 500,
        nextScreen: OurNavigationBar(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Colors.white
      )
    );
  },
  );
}