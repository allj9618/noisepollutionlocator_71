import 'package:shared_preferences/shared_preferences.dart';
import 'favorite_adress.dart';

class AddFavorite {
  final FavoriteAddress favAddress;
  final bool isMap;
  String setFavorites;

  AddFavorite(this.favAddress, this.isMap) {
    if (isMap == true)
      this.setFavorites = "mapFavorites";
    else
      this.setFavorites = "ownMeasureFavorites";
  }

  add() async {
    if (!isMap) {
      try {
        int.parse(favAddress.decibel);
      } on Exception {
        print('String decibel needs to be parsable to an int');
        return;
      }
    }
    _checkStrings();

    List<String> tempFav = <String>[];
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getStringList(setFavorites) != null) {
      tempFav = prefs.getStringList(setFavorites);
    }

    tempFav.add(favAddress.encodeFavorite(favAddress));
    prefs.setStringList(setFavorites, tempFav);
  }

  void _checkStrings() {
    if (favAddress.address.isEmpty) {
      throw new Exception('String address/name cannot be empty');
    }
    if (!isMap) {
      if (int.parse(favAddress.decibel) <= 0 ||
          int.parse(favAddress.decibel) >= 200) {
        throw new Exception('String decibel has to be more or equal to 0 and less than 200');
      }
    }
    else if (isMap) {
      for (int i = 0; i < favAddress.decibel.length; i++) {
        var char = favAddress.decibel[i];
        if (char != "+" && char != "." && int.parse(char) is! int) {
          throw new Exception('bad format');
        }
      }
    }
  }


}
