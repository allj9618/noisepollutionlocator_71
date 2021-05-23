import 'package:flutter/material.dart';
import 'package:noisepollutionlocator_71/favorite/favorite_shared_preferences.dart';
import 'package:noisepollutionlocator_71/themes.dart';
import 'package:settings_ui/settings_ui.dart';
import 'favorite/favorite_add.dart';
import 'favorite/favorite_adress.dart';
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

             // Example
              SettingsTile(
                title: 'add random fav',
                leading: Icon(Icons.add),
                onPressed: (context) {
                  AddFavorite add = AddFavorite(new FavoriteAddress(address: "Testgatan", location: "Test", decibel: "77"), true);
                  AddFavorite add1 = AddFavorite(new FavoriteAddress(address: "Datagatan", location: "Test", decibel: "60"), true);
                  AddFavorite add2 = AddFavorite(new FavoriteAddress(address: "A", location: "Test", decibel: "55"), true);
                  AddFavorite add3 = AddFavorite(new FavoriteAddress(address: "B", location: "Test", decibel: "13"), true);
                  AddFavorite add4 = AddFavorite(new FavoriteAddress(address: "C", location: "Test", decibel: "12"), true);
                  add.addFavorite();
                  add1.addFavorite();
                  add2.addFavorite();
                  add3.addFavorite();
                  add4.addFavorite();
                  AddFavorite ad = AddFavorite(new FavoriteAddress(address: "A", location: "Test", decibel: "77"), false);
                  AddFavorite ad1 = AddFavorite(new FavoriteAddress(address: "B", location: "Test", decibel: "20"), false);
                  AddFavorite ad2 = AddFavorite(new FavoriteAddress(address: "ARKGATAN", location: "Test", decibel: "40"), false);
                  AddFavorite ad3 = AddFavorite(new FavoriteAddress(address: "VESTGATA", location: "Test", decibel: "13"), false);
                  AddFavorite ad4 = AddFavorite(new FavoriteAddress(address: "CEGATAN", location: "Test", decibel: "12"), false);
                  ad.addFavorite();
                  ad1.addFavorite();
                  ad2.addFavorite();
                  ad3.addFavorite();
                  ad4.addFavorite();
                } ,
              ),

              SettingsTile(
                title: 'remove all fav',
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


