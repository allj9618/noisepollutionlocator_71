import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noisepollutionlocator_71/location.dart';
import 'package:noisepollutionlocator_71/map.dart';
import 'package:noisepollutionlocator_71/settings.dart';
import 'favorites.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';

class OurNavigationBar extends StatefulWidget{
  OurNavigationBar({Key key}) : super(key: key);

  @override
  _OurNavigationBarState createState() => _OurNavigationBarState();
}

class _OurNavigationBarState extends State<OurNavigationBar>{
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    Map(),
    Favorites(),
    Location(),
    Settings()
  ];

  /*void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    }); Duplicate setState-function, perhaps it belonged to the ordinary BottomNavBar before FF.
  }*/

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Noise Pollution Locator'),
        backgroundColor: Theme.of(context).primaryColor
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: FFNavigationBar(
        theme: FFNavigationBarTheme(
          barBackgroundColor: Colors.white,
          selectedItemBackgroundColor: Colors.black,
          selectedItemIconColor: Colors.white,
          selectedItemLabelColor: Colors.black,
          unselectedItemIconColor: Colors.grey,
          unselectedItemLabelColor: Colors.black,
        ),
        selectedIndex: _selectedIndex,
        onSelectTab: (index){
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          FFNavigationBarItem(
            iconData: Icons.map,
            label: 'Map',
          ),
          FFNavigationBarItem(
            iconData: Icons.favorite,
            label: 'Favorites',
          ),
          FFNavigationBarItem(
            iconData: Icons.gps_fixed,
            label: 'Location',
          ),
          FFNavigationBarItem(
            iconData: Icons.settings,
            label: 'Settings',
          )
        ],
      )
    );
  }
}