import 'package:flutter/material.dart';
import 'package:noisepollutionlocator_71/themes.dart';
import 'package:settings_ui/settings_ui.dart';
import 'favorite/favorite_shared_preferences.dart';
import 'google_sign_in.dart';
import 'translations.dart';
import 'translationApplication.dart';

// https://pub.dev/packages/settings_ui
// Settings template

class Settings extends StatefulWidget {
  @override
  _Settings createState() => _Settings();
}

class _Settings extends State<Settings> {
  //String dropdownValue = AppLocalizations.of(context).languageChoice;
 // bool value = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Translations.of(context).text('settingsTitle'))),
      body: SettingsList(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        sections: [
          SettingsSection(
            tiles: [
              SettingsTile(
                title: Translations.of(context).text('language'),
                subtitle: Translations.of(context).text('languageChoice'),
                leading: Icon(Icons.language),
                onPressed: (BuildContext context) {
                  if(Translations.of(context).currentLanguage == 'en'){
                    applic.onLocaleChanged(new Locale('se',''));
                  }else{
                    applic.onLocaleChanged(new Locale('en',''));
                  }
                },
              ),
              SettingsTile(
                title: Translations.of(context).text('theme'),
                leading: Icon(Icons.wb_sunny_outlined),
                trailing: ChangeThemeButtonWidget(),
              ),
              SettingsTile(
                title: "Google Sign-In",
                leading: Icon(Icons.person),
                onPressed: (context) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignInGoogle()),
                  );
                },
              ),
              SettingsTile(
                //title: 'Remove all favorites',
                title: Translations.of(context).text("removeFav"),
                leading: Icon(Icons.remove),
                onPressed: (BuildContext context) {
                  FavoriteSharedPreferences.removeAll();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}


