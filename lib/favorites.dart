import 'package:flutter_slidable/flutter_slidable.dart';
import 'favorite_adress.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//stackoverflow.com/questions/63863854/how-to-save-and-read-a-list-of-class-object-using-shared-preferences-in-flutter

// https://pub.dev/packages/flutter_slidable
// https://pub.dev/packages/shared_preferences

class Favorites extends StatefulWidget {
  @override
  FavoritesState createState() => FavoritesState();
}

class FavoritesState extends State<Favorites> {
  static List<String> _favorite = <String>[];

  @override
  void initState() {
    _update();
    super.initState();
  }

  // Use to save fav location.
  static Future<void> addFavorite(String a, l, d) async {
    FavoriteAddress newFav =
        new FavoriteAddress(address: a, location: l, decibel: d);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _favorite.add(newFav.encodeFavorite(newFav));
    prefs.setStringList('favorites', _favorite);
  }

  removeFavorite(int index) async {
    _favorite.removeAt(index);
    await setListToSharedPrefLocation();
  }

  Future setListToSharedPrefLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('favorites', _favorite);
    _favorite = prefs.getStringList('favorites');
  }

  void _update() {
    SharedPreferences.getInstance().then((SharedPreferences sp) {
      var sharedPreferences = sp;
      _favorite = sharedPreferences.getStringList('favorites');
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_favorite.isNotEmpty) {
      return Scaffold(
          appBar: AppBar(title: Center(child: Text('Saved Locations'))),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Container(
              color: Colors.white,
              child: ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                        color: Colors.lightGreenAccent,
                      ),
                  itemCount: _favorite.length,
                  itemBuilder: (context, int index) {
                    FavoriteAddress currfav = FavoriteAddress();
                    currfav = currfav.decodedFavorite(_favorite[index]);
                    return Slidable(
                        actionPane: SlidableDrawerActionPane(),
                        actionExtentRatio: 0.25,
                        child: Container(
                          color: Colors.white,
                          child: ListTile(
                            title: Row(
                              children: [
                                Text(
                                  currfav.address,
                                  style: TextStyle(
                                    fontSize: 20,
                                    height: 3,
                                  ),
                                ),
                                Spacer(),
                                _buildTrailingText(currfav.decibel),
                              ],
                            ),
                            subtitle: Text(
                              ' ' + currfav.location,
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            dense: false,
                          ),
                        ),
                        secondaryActions: <Widget>[
                          IconSlideAction(
                            caption: 'Delete',
                            color: Colors.red,
                            icon: Icons.delete,
                            onTap: () {
                              setState(() {
                                removeFavorite(index);
                              });
                            },
                          )
                        ]);
                  })));
    } else
      return Scaffold(
          appBar: AppBar(title: Center(child: Text('Saved Locations'))),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Center(
            child: Text('No favorites saved!'),
          ));
  }

  Text _buildTrailingText(String decibel) {
    return Text(
      (decibel + ' db'),
      style: TextStyle(
        color: _buildColors(int.parse(decibel)),
        fontSize: 20,
        height: 3,
      ),
    );
  }

  Color _buildColors(int decibelValue) {
    if (decibelValue >= 0 && decibelValue <= 53) return Colors.green;
    if (decibelValue > 53 && decibelValue <= 59) return Colors.lightGreen;
    if (decibelValue > 59 && decibelValue <= 65) return Colors.yellow;
    if (decibelValue > 65 && decibelValue <= 73)
      return Colors.orange;
    else
      return Colors.red;
  }
}
