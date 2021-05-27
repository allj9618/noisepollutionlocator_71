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
    List<String> favMap;
    List<String> ownMap;
    if (selectedTab) {
      favMap = prefs.getStringList(mapFavorites);
    }
    if (!selectedTab) {
      ownMap = prefs.getStringList(ownMeasureFavorites);
    }

    if (selectedTab)
      favMap.removeAt(index);
    if (!selectedTab)
      ownMap.removeAt(index);

    setLists(favMap, ownMap);
    setStateOnFavLists(favMap, ownMap);
  }

    Future<void> setLists( List<String> favMap, List<String> ownMap) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (favMap != null)
      prefs.setStringList(mapFavorites, favMap);
      else if (ownMap != null)
      prefs.setStringList(ownMeasureFavorites, ownMap);
    }

  static removeAll() async{
  SharedPreferences myPrefs = await SharedPreferences.getInstance();
  return myPrefs.clear();
  }

}