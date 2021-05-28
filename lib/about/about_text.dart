import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:noisepollutionlocator_71/translations.dart';


class TextContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          title1(context),
          Separator(),
          textBlock1(context),
          Separator2(),
          SizedBox(height: 50),
          title2(context),
          Separator(),
          textBlock2(context),
          Separator2(),
          SizedBox(height: 50),
          title3(context),
          Separator(),
          textBlock3(context),
          Separator2(),
          SizedBox(height: 50),
          title4(context),
          Separator(),
          textBlock4(context),
          Separator2(),
          SizedBox(height: 50),
        ],
      ),
    );
  }

  title1(context) {
    return Align(
        alignment: Alignment.topLeft,
        //child: Text("WHAT IS NOISE POLLUTION?".toUpperCase(),
        child: Text(Translations.of(context).text("whatIsNoise").toUpperCase(),
            style: titleStyle(context)));
  }


  title2(context) {
    return Align(
        alignment: Alignment.topLeft,
        child: Text(
          //"WHY SHOULD I USE THIS APPLICATION?".toUpperCase(),
          Translations.of(context).text("whyUse").toUpperCase(),
          style: titleStyle(context),
        ));
  }

  title3(context) {
    return Align(
        alignment: Alignment.topLeft,
        child: Text(
          //"HOW DO I USE THIS \nAPPLICATION?".toUpperCase(),
          Translations.of(context).text("howUse").toUpperCase(),
          style: titleStyle(context),
        ));
  }
  title4(context) {
    return Align(
        alignment: Alignment.topLeft,
        child: Text(Translations.of(context).text("NOTE").toUpperCase(),
            style: titleStyle(context)));
  }

  textBlock1(context) {
    return Text.rich(
      TextSpan(children: [
        TextSpan(
          text:
              //"Noise pollution can be described as undesirable sounds that can interfere with regular activities in our daily lives, e.g ..sleep, speech or disrupts or decreases one's quality of life.\n\nIt's a problem that affects many people, especially those who live in cities or close to cars, railways, playgrounds or other trafficked areas. \n\nAccording to the ",
          Translations.of(context).text("firstText"),
          style: textBlockStyle(context),
        ),
        linkToFOHM.text,
        TextSpan(
          text:
              //", noise and high noise levels affect human health in different ways depending on what type of noise it is. And that high noise levels can cause hearing damage in the form of, for example hearing loss, tinnitus and sound hypersensitivity.\n\nMany studies have concluded that being exposed to high noise levels for an extended period of time can cause physical issues such as temporary or permanent damage to one's hearing ability or other issues like disturbing one's sleep.",
          Translations.of(context).text("secondText"),
        style: textBlockStyle(context),
        ),
      ]),
    );
  }

  textBlock2(context) {
    return Text(
      //"This application is pretty unique in that it offers a way for the user to see what areas in Stockholm are noisy or has a potentially dangerous level of noise pollution measured in decibel.\n\nMaybe you are looking for a new home to live in a quiet place or you are a yoga instructor that wants to find an outdoor area to hold your yoga classes. Then this app can be of use for you.",
      Translations.of(context).text("thirdText"),
      style: textBlockStyle(context),
    );
  }

  textBlock3(context) {
    return Text(
      //"Currently you can check out the map that visually tells you areas and their noise levels measured in decibel.\n\nYou can save addresses you have checked out. In the future you can measure the noise level in the area together with other users to get more accurate data. \n\nOur map shows mean equivalent decibel values from a 24-hour period, measured at 2m above the ground, and is based on the results from a survey on noise pollution in Stockholm from 2012 which include readings of traffic flow from roads, trains and aeroplanes. ",
      Translations.of(context).text("fourthText"),
      style: textBlockStyle(context),
    );
  }

  // Add some kind of decibel graph?
  // ex. https://medium.com/flutterdevs/animated-bar-chart-in-flutter-85e58ebd29ed
  textBlock4(context) {
    return Text(
      Translations.of(context).text("unreliable"),
      style: textBlockStyle(context),
    );
  }
}


titleStyle(context) {
  return TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 22,
      letterSpacing: 2,
      wordSpacing: 2,
      color: Theme.of(context).textTheme.bodyText2.color);
}

textBlockStyle (context) {
  return TextStyle(
    fontSize: 20,
    letterSpacing: 1,
    wordSpacing: 2,
    color: Theme.of(context).textTheme.bodyText2.color
  );
}
var alignmentForTitle = Align(
  alignment: Alignment.topLeft,
);

var linkToFOHM = RichText(
    softWrap: false,
    text: TextSpan(
        text: "Folkhälsomyndigheten/Public Health Agency of Sweden",
        style: TextStyle(
            fontSize: 20, letterSpacing: 1, wordSpacing: 2, color: Colors.blue),
        recognizer: TapGestureRecognizer()
          ..onTap = () async {
            var url =
                "https://www.folkhalsomyndigheten.se/the-public-health-agency-of-sweden";
            launch(url);
          }));

class Separator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Align(
        alignment: Alignment.topLeft,
        child: Container(
            margin: new EdgeInsets.symmetric(vertical: 10.0),
            height: 0.7,
            width: 35.0,
            color: new Color(0xff00c6ff)));
  }
}

class Separator2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Align(
        alignment: Alignment.center,
        child: Container(
            margin: new EdgeInsets.symmetric(vertical: 30.0),
            height: 0.5,
            width: 250.0,
            color: Colors.grey.withOpacity(0.3)));
  }
}

