import 'package:flutter_slidable/flutter_slidable.dart';
import 'favorite_adress.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
TODO:
     1. Make it possible to display to different lists for map and ownmeasurments [Done].
     2. Sort by name
     3. Sort by noise levels.
 */

class Favorites extends StatefulWidget {
  @override
  FavoritesState createState() => FavoritesState();
}

class FavoritesState extends State<Favorites> {
  final String favorites = "favorites";
  final String ownMeasur = "ownMeasurements";
  List<String> _favorite = <String>[];
  List<String> _ownMeasurents = <String>[];

  @override
  void initState() {
    update();
    super.initState();
  }

  static removeAllFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  removeFavorite(int index, List<String> currentSharedList) async {

    if (currentSharedList == _favorite) {
      _favorite.removeAt(index);
    }
     else if (currentSharedList == _ownMeasurents) {
        _ownMeasurents.removeAt(index);
      }

    await _setListToSharedPrefLocation();
  }

  Future _setListToSharedPrefLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
        prefs.setStringList(favorites, _favorite);
        _favorite = prefs.getStringList(favorites);

        prefs.setStringList(ownMeasur, _ownMeasurents);
       _ownMeasurents = prefs.getStringList(ownMeasur);
    }


    );
  }

  Future<void> update() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getStringList(favorites) != null) {
      setState(() {
        _favorite = prefs.getStringList(favorites);
      });
    }

    if (prefs.getStringList(ownMeasur) != null) {
      setState(() {
        _ownMeasurents = prefs.getStringList(ownMeasur);
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return
      // MaterialApp(
      // theme: ,
      //   home:
        DefaultTabController(
            length: 2,
            child: Scaffold(
              //backgroundColor: Theme.of(context).scaffoldBackgroundColor ,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(50.0),
                child: AppBar(
                  bottom: TabBar(
                    tabs: [
                      Tab(icon: Icon(Icons.map)),
                      Tab(icon: Icon(Icons.mobile_screen_share_rounded)),
                    ],
                  ),
                ),
              ),
              body: TabBarView(
                children: [
                  buildList(this._favorite, context),
                  buildList(this._ownMeasurents, context)],
              ),
            ));
  }

  Container buildList(List<String> sharedList, context) {
    return Container(
        child: sharedList.length == 0
            ? Center(child: Text('No favorites to display'))
            : ListView.separated(
                separatorBuilder: (context, index) => Divider(
                      color: Colors.lightGreenAccent,
                    ),
                itemCount: sharedList.length,
                itemBuilder: (context, index) {
                  FavoriteAddress currFav = FavoriteAddress();
                  currFav = currFav.decodedFavorite(sharedList[index]);
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
                        ),
                      ),
                      secondaryActions: <Widget>[
                        IconSlideAction(
                          caption: 'Delete',
                          color: Colors.red,
                          icon: Icons.delete,
                          onTap: () {
                            setState(() {
                              removeFavorite(index, sharedList);
                            });
                          },
                        )
                      ]);
                }));
  }

  Text _locationText(String subtitle) {
    return Text(
      ' ' + subtitle,
      style: TextStyle(
        fontSize: 17,
      ),
    );
  }

  Text _addressText(String address) {
    return Text(
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
