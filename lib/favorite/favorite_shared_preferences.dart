import 'package:shared_preferences/shared_preferences.dart';

class FavoriteSharedPreferences {
  final Function setStateOnFavLists;
  final String mapFavorites = "mapFavorites";
  final String ownMeasureFavorites = "ownMeasureFavorites";

  FavoriteSharedPreferences(this.setStateOnFavLists);

  Future<void> update(List<String> favMap, favOwn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.getStringList(mapFavorites) != null)
        favMap = prefs.getStringList(mapFavorites);

      if (prefs.getStringList(ownMeasureFavorites) != null)
        favOwn = prefs.getStringList(ownMeasureFavorites);

      setStateOnFavLists(favMap,favOwn);
  }

    removeFavorite(int index, bool selectedTab) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> favMap = prefs.getStringList(mapFavorites);
    List<String> ownMap = prefs.getStringList(ownMeasureFavorites);

    if (selectedTab)
      favMap.removeAt(index);
    if (!selectedTab)
      ownMap.removeAt(index);

    prefs.setStringList(mapFavorites, favMap);
    prefs.setStringList(ownMeasureFavorites, ownMap);

    setStateOnFavLists(favMap, ownMap);

  }

  static removeAll() async{
  SharedPreferences myPrefs = await SharedPreferences.getInstance();
  return myPrefs.clear();
  }

}