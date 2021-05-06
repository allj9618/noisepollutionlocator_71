import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class about extends StatelessWidget {
  const about({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.help_outline_sharp,
        size: 30,
        color: Colors.white,
      ),
      onPressed: () {
        // do something
      },
    );
  }




}