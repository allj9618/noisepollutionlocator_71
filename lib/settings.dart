import 'package:flutter/material.dart';
import 'package:noisepollutionlocator_71/themes.dart';
import 'package:settings_ui/settings_ui.dart';
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
            subtitle: Center(
                child: Text(
                  Translations.of(context).text('settingsTitle'),
                )),
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
                title: Translations.of(context).text('email'),
                leading: Icon(Icons.mail),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile(
                title: Translations.of(context).text('password'),
                leading: Icon(Icons.lock),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile(
                title: Translations.of(context).text('theme'),
                leading: Icon(Icons.wb_sunny_outlined),
                trailing: ChangeThemeButtonWidget(),
              )
            ],
          ),
        ],
      ),
    );
  }
}


