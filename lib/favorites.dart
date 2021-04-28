import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
/*

TODO:
 * Test it out with map.dart or location.dart. []
 * Remove favorite/Clear all []
 * Style the favorites []

 */

// class SavedFavorite {
//   final String location;
//   final int decibel;
//
//   SavedFavorite(this.location, this.decibel);
// }

class Favorites extends StatefulWidget {
  @override
  _Favorites createState() => _Favorites();
}

class _Favorites extends State<Favorites> {

  List<String> favorite = ['Cordinates 60', 'Cordinates 40'];

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {

    await addFavorite('Test');

    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      favorite = prefs.getStringList('favorites');
    });
  }

  Future<void> addFavorite(String newFav) async {
    favorite.add(newFav);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('favorites', favorite);
  }

  Future<void> removeFavorite(String oldFav) async {
    favorite.remove(oldFav);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('favorites', favorite);
  }

  @override
  Widget build(BuildContext context) {
    if (favorite.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text('Favorites')),
        body: Container(
          child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: favorite.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(title: Text(favorite[index]));
              }
            // },
          ),
        ),
      );
    }
    else
      return Scaffold(
          appBar: AppBar(title: Text('Favorites')),
          body: Center(
            child: Text('No Favorites saved!'),
          )
      );
  }
}