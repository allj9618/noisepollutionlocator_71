import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noisepollutionlocator_71/location.dart';
import 'package:noisepollutionlocator_71/map.dart';
import 'package:noisepollutionlocator_71/settings.dart';
import 'package:noisepollutionlocator_71/home_button.dart';
import 'externalAPIinterface.dart';
import 'favorites.dart';

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      routes: {
        '/settings': (context) => Settings(),
        '/external_api': (context) => ExternalAPI(),
        '/map': (context) => Map(),
        '/location': (context) => Location(),
        //'/favorites': (context) => Favorites(),
      },

      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blue,
        accentColor: Colors.black,
        textTheme: TextTheme(
          bodyText1: TextStyle(),
          bodyText2: TextStyle(),
        ).apply(
          bodyColor: Colors.grey,
          displayColor: Colors.black,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        accentColor: Colors.white,
        textTheme: TextTheme(
          bodyText1: TextStyle(),
          bodyText2: TextStyle(),
        ).apply(
          bodyColor: Colors.white,
          displayColor: Colors.grey,
        ),
      ),
      home: MyHomePage(title: 'Noise Pollution Locator'),
    );
  }
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(20.0),
                    child: MenuButton('/external_api', 'External API')),
                Padding(
                    padding: EdgeInsets.all(20.0),
                    child: MenuButton('/settings', 'Settings')),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(20.0),
                    child: MenuButton('/location', 'Location')),
                Padding(
                    padding: EdgeInsets.all(20.0),
                    child: MenuButton('/map', 'Map')),
              ],
            ),
          ],

        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Theme.of(context).accentColor,),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.map, color: Theme.of(context).accentColor,),
              label: 'Map'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite, color: Theme.of(context).accentColor,),
              label: 'Favorite'
          ),
        ],
        iconSize: 50,
      ),
    );
  }
}

  void openMyLocationPage(BuildContext context) {

  }