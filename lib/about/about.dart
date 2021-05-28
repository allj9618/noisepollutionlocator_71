import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noisepollutionlocator_71/about/about_text.dart';
import 'package:noisepollutionlocator_71/translations.dart';

// https://www.folkhalsomyndigheten.se/livsvillkor-levnadsvanor/miljohalsa-och-halsoskydd/tillsynsvagledning-halsoskydd/buller/

class About extends StatelessWidget {
  const About({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.info_outline_rounded,
        size: 30,
      ),
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return AboutScaffold();
        }));
      },
    );
  }
}

class AboutScaffold extends StatelessWidget {

  @override
  Widget build(BuildContext context) {


    return new Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Container(
          alignment: Alignment.centerLeft,
          //child: Text("About us",
          child: Text(Translations.of(context).text('aboutUs'),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: new Column(
            children: <Widget>[_upperBodyContent(context), _textContent()],
          ),
        ),
      );
   // );
  }
}


Widget _upperBodyContent(context) {
  return Column(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset('assets/logopng.png',
            height: 150, width: 150, colorBlendMode: BlendMode.srcOver),
      ),
      Padding(
        padding: const EdgeInsets.all(40.0),
        child: Text(
            //"About us",
            Translations.of(context).text("_aboutUs"),
             style: TextStyle(
             fontSize: 25,
             color: Theme.of(context).textTheme.bodyText2.color
          ),
        ),
      ),
    ],
  );
}

Widget _textContent() {
  return new Container(
      padding: new EdgeInsets.symmetric(horizontal: 32.0),
      child: new Column(
        children: <Widget>[Container(child: TextContent())],
      ));
}