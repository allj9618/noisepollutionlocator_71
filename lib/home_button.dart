import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MenuButton extends StatelessWidget {

  final String button_name;
  final String route;

  MenuButton(this.route, this.button_name);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
       height: 100,
       minWidth: 150,
       color: Theme
        .of(context)
        .primaryColor,
    textColor: Colors.white,
    child: new Text('$button_name'),

    onPressed: () => {
         if (route != null) {
           Navigator.of(context).pushNamed('$route')
         }
    },
    splashColor: Colors.blue,
    );
  }
}