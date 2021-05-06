import 'package:flutter/material.dart';
import 'package:noisepollutionlocator_71/themes.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'LanguagesScreen.dart';


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
      appBar: AppBar(title: Text(AppLocalizations.of(context).settingsTitle)),
      body: SettingsList(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        sections: [
          SettingsSection(
            subtitle: Center(
                child: Text(
                  AppLocalizations.of(context).settingsTitle,
                )),
            tiles: [
              SettingsTile(
                title: AppLocalizations.of(context).language,//language egentligen
                subtitle: AppLocalizations.of(context).languageChoice,
                leading: Icon(Icons.language),
                onPressed: (BuildContext context) {
                  setState(() {
                    AppLocalizations.delegate.load(Locale('se',''));
                  });
                  /*Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => LanguagesScreen(),
                  ));*/
                },
              ),
              SettingsTile(
                title: AppLocalizations.of(context).email,
                leading: Icon(Icons.mail),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile(
                title: AppLocalizations.of(context).password,
                leading: Icon(Icons.lock),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile(
                title: AppLocalizations.of(context).theme,
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


