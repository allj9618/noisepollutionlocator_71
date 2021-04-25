import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noisepollutionlocator_71/location.dart';
import 'package:noisepollutionlocator_71/map.dart';
import 'package:noisepollutionlocator_71/settings.dart';
import 'package:noisepollutionlocator_71/home_button.dart';
import 'externalAPIinterface.dart';

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
                    child: MenuButton('/external_api', 'External API Test')),

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
    );
  }
}

  void openMyLocationPage(BuildContext context) {

  }