import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noisepollutionlocator_71/home_button.dart';


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