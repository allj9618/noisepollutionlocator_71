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
  List<String> _favorite = <String>[];

  @override
  void initState() {
    update();
    super.initState();
  }

  static addFav(String a, l, d) async {
    List<String> tempFav = <String>[];

    FavoriteAddress newFav =
        new FavoriteAddress(address: a, location: l, decibel: d);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    tempFav = prefs.getStringList('favorites');
    tempFav.add(newFav.encodeFavorite(newFav));
    prefs.setStringList('favorites', tempFav);
  }

  removeFavorite(int index) async {
    _favorite.removeAt(index);
    await setListToSharedPrefLocation();
  }

  Future setListToSharedPrefLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setStringList('favorites', _favorite);
      _favorite = prefs.getStringList('favorites');
    });
  }

  Future<void> update() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _favorite = prefs.getStringList('favorites');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Container(
            child:  _favorite.length == 0 ? Center(child: Text('No favorites to display')):
            ListView.separated(
                separatorBuilder: (context, index) => Divider(
                      color: Colors.lightGreenAccent,
                    ),
                  itemCount: _favorite.length,
                  itemBuilder: (context, int index) {
                  FavoriteAddress currFav = FavoriteAddress();
                  currFav = currFav.decodedFavorite(_favorite[index]);
                  return Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: 0.25,
                      child: Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: ListTile(
                          title: Row(
                            children: [
                             _addressText(currFav.address),
                              Spacer(),
                              _buildTrailingText(currFav.decibel),
                            ],
                          ),
                          subtitle: _locationText(currFav.location),
                         // dense: false,
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
  }

  Text _locationText (String subtitle) {
    return  Text(
      ' ' + subtitle,
      style: TextStyle(
        fontSize: 17,
      ),
    );
  }

  Text _addressText (String address) {
    return  Text(
      address,
      style: TextStyle(
        fontSize: 20,
        height: 3,
      ),
    );
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
