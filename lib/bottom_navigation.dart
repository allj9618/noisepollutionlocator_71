
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noisepollutionlocator_71/location.dart';
import 'package:noisepollutionlocator_71/map.dart';
import 'package:noisepollutionlocator_71/settings.dart';
import 'externalAPIinterface.dart';
import 'home_page.dart';

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      routes: {
        '/settings': (context) => Settings(),
        '/external_api': (context) => ExternalAPI(),
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
    MyHomePage(title: 'Home Page'),
    Location(),
    Map(),
    Settings()
  ];

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

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
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem> [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.blue
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.gps_fixed),
              label: 'Location',
              backgroundColor: Colors.blue
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Map',
              backgroundColor: Colors.blue
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
              backgroundColor: Colors.blue
          ),
        ],
        type: BottomNavigationBarType.shifting,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        iconSize: 40,
        onTap: _onItemTapped,
        elevation: 5,
      )
    );
  }
}