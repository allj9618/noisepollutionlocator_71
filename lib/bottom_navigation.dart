import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noisepollutionlocator_71/map.dart';
import 'package:noisepollutionlocator_71/noisemeter.dart';
import 'package:noisepollutionlocator_71/settings.dart';

import 'about/about.dart';
import 'favorite/favorites.dart';
import 'translations.dart';

class OurNavigationBar extends StatefulWidget {
  OurNavigationBar({Key key}) : super(key: key);

  @override
  _OurNavigationBarState createState() => _OurNavigationBarState();
}

class _OurNavigationBarState extends State<OurNavigationBar> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    Map(),
    Favorites(),
    NoiseMeterApp(),
    Settings()
  ];

  /*void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    }); Duplicate setState-function, perhaps it belonged to the ordinary BottomNavBar before FF.
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Image.asset('assets/logopng.png'),
          actions: <Widget>[About()],
          title: const Text('Notice Noise'),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: FFNavigationBar(
          theme: FFNavigationBarTheme(
            barBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
            selectedItemBackgroundColor: Theme.of(context).primaryColor,
            selectedItemIconColor: Theme.of(context).accentColor,
            selectedItemLabelColor: Theme.of(context).accentColor,
            selectedItemBorderColor: Theme.of(context).accentColor,
            unselectedItemIconColor: Theme.of(context).focusColor,
            unselectedItemLabelColor: Theme.of(context).accentColor,
          ),
          selectedIndex: _selectedIndex,
          onSelectTab: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: [
            FFNavigationBarItem(
              iconData: Icons.map,
              label: Translations.of(context).text("map"),
            ),
            FFNavigationBarItem(
              iconData: Icons.favorite,
              label: Translations.of(context).text('favorite'),
            ),
            FFNavigationBarItem(
              iconData: Icons.mic_none_rounded,
              label: Translations.of(context).text('noisemeter'),
            ),
            FFNavigationBarItem(
              iconData: Icons.settings,
              label: Translations.of(context).text('settingsTitle'),
            )
          ],
        ));
  }
}
