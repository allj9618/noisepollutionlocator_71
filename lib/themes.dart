import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        bodyColor: Colors.grey[850], //Before: Colors.grey
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
        bodyColor: Colors.white, // Before: amber.shade900
        //displayColor: Colors.blue,
    ),
  );
}

class ThemeProvider extends ChangeNotifier {
    ThemeMode themeMode = ThemeMode.dark;

    bool get isDarkMode => themeMode == ThemeMode.dark;

    void toggleTheme(bool isOn) {
      themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
      notifyListeners();
    }
}

class ChangeThemeButtonWidget extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        
        return Switch.adaptive(
          value: themeProvider.isDarkMode,
          onChanged: (value) {
            final provider = Provider.of<ThemeProvider>(context, listen: false);
              provider.toggleTheme(value);
            },
        );
    }
}