import 'package:flutter/material.dart';
import 'package:noisepollutionlocator_71/themes.dart';
import 'package:settings_ui/settings_ui.dart';
import 'favorite/favorite_add.dart';
import 'favorite/favorite_adress.dart';
import 'favorite/favorites.dart';
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
                title: 'add random fav',
                leading: Icon(Icons.add),
                onPressed: (context) {
                  FavoriteAddress newFav = new FavoriteAddress(address: "Test", location: "Test", decibel: "50");
                  AddFavorite add = AddFavorite(newFav, true);
                  add.addFavorite();
                } ,
              ),

              SettingsTile(
                title: 'remove all fav',
                leading: Icon(Icons.remove),
                onPressed: (BuildContext context) {
                  FavoritesState.removeAllFavorites();
                },
              ),

            ],
          ),
        ],
      ),
    );
  }
}


