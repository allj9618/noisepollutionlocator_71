import 'package:flutter_slidable/flutter_slidable.dart';
import 'favorite_adress.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


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

  static remFav() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  static addFav(String a, String l, String d) async {

    try {
      int.parse(d);
    }   on Exception {
        print('String d needs to be parsable to an int');
        return;
    }

    if (a.isEmpty || l.isEmpty ) {
      throw new Exception('String address or location cannot be empty');
    }

    if (int.parse(d) < 0 || int.parse(d) >= 200) {
      throw new Exception('String decibel has to be more than 0 and less than 200');
    }

    List<String> tempFav = <String>[];

    FavoriteAddress newFav = new FavoriteAddress(address: a, location: l, decibel: d);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getStringList('favorites') != null) {
        tempFav = prefs.getStringList('favorites');
    }

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
    if (prefs.getStringList('favorites') != null) {
      setState(() {
        _favorite = prefs.getStringList('favorites');
      });
    }
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
                  itemBuilder: (context, index) {
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
