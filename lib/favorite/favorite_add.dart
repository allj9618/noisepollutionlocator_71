import 'package:shared_preferences/shared_preferences.dart';
import 'favorite_adress.dart';

class AddFavorite {

  FavoriteAddress favAddress;
  bool isMap;
  String sharedList;

  AddFavorite(this.favAddress, this.isMap) {
    if (isMap == true)
      this.sharedList = "favorites";
      else
        this.sharedList = "ownMeasurements";
  }

   addFavorite() async {
    print(sharedList);

    try {
      int.parse(favAddress.decibel);
    } on Exception {
      print('String d needs to be parsable to an int');
      return;
    }

    checkStrings();
    List<String> tempFav = <String>[];
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getStringList(sharedList) != null) {
      tempFav = prefs.getStringList(sharedList);
    }

    tempFav.add(favAddress.encodeFavorite(favAddress));
    prefs.setStringList(sharedList, tempFav);
  }

   void checkStrings() {
       if (favAddress.address.isEmpty || favAddress.location.isEmpty) {
      throw new Exception('String address or location cannot be empty');
    }

    if (int.parse(favAddress.decibel) < 0 || int.parse(favAddress.decibel) >= 200) {
      throw new Exception(
          'String decibel has to be more than 0 and less than 200');
    }
  }
}