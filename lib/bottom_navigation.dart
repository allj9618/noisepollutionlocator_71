
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noisepollutionlocator_71/location.dart';
import 'package:noisepollutionlocator_71/map.dart';
import 'package:noisepollutionlocator_71/settings.dart';
import 'home_page.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      routes: {
        '/settings': (context) => Settings(),
        '/map': (context) => Map(),
        '/location': (context) => Location(),
      },

      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OurNavigationBar(),
    );
  }
}

class OurNavigationBar extends StatefulWidget{
  OurNavigationBar({Key key}) : super(key: key);

  @override
  _OurNavigationBarState createState() => _OurNavigationBarState();
}

class _OurNavigationBarState extends State<OurNavigationBar>{
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    Map(),
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
        title: const Text('Noise Pollution App'),
        backgroundColor: Colors.blue
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: FFNavigationBar(
        theme: FFNavigationBarTheme(
          barBackgroundColor: Colors.blue,
          selectedItemBackgroundColor: Colors.blue,
          //selectedItemIconColor: Colors.black,
          selectedItemLabelColor: Colors.white,
          unselectedItemIconColor: Colors.white,
          unselectedItemLabelColor: Colors.white,
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