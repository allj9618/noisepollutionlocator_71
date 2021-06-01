import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:noise_meter/noise_meter.dart';
import 'package:noisepollutionlocator_71/translations.dart';
import 'favorite/favorite_add.dart';
import 'favorite/favorite_adress.dart';

class NoiseMeterApp extends StatefulWidget {
  @override
  _NoiseMeterState createState() => _NoiseMeterState();
}

class _NoiseMeterState extends State<NoiseMeterApp> {
  bool _isRecording = false;
  StreamSubscription<NoiseReading> _noiseSubscription;
  NoiseMeter _noiseMeter;
  String _meanDecibelLevel = "None";
  var _decibelreadings = [];
  var _averagedecibel = 0.0;
  var _totaldecibel = 0.0;

  @override
  void initState() {
    super.initState();
    _noiseMeter = new NoiseMeter(onError);
  }

  void onData(NoiseReading noiseReading) {
    this.setState(() {
      if (!this._isRecording) {
        this._isRecording = true;
      }
    });
    _meanDecibelLevel = noiseReading.meanDecibel.toString();
    _decibelreadings.add(noiseReading.meanDecibel);
  }

  void onError(PlatformException e) {
    print(e.toString());
    _isRecording = false;
  }

  void start() async {
    _decibelreadings = [];
    try {
      _noiseSubscription = _noiseMeter.noiseStream.listen(onData);
    } catch (err) {
      print(err);
    }
  }

  void stop() async {
    _totaldecibel = 0.0;
    try {
      if (_noiseSubscription != null) {
        _noiseSubscription.cancel();
        _noiseSubscription = null;
      }
      this.setState(() {
        this._isRecording = false;
      });
      _decibelreadings.removeAt(0);
      _decibelreadings.forEach((element) {
        _totaldecibel += element;
      });
      _averagedecibel = _totaldecibel / _decibelreadings.length;
      showDialog(
        context: context,
        builder: (BuildContext context) =>
            _buildPopupDialog1(context, _averagedecibel),
      );
    } catch (err) {
      print('stopRecorder error: $err');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
            child: Stack(
                children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Transform.scale(
                scale: 4,
                child: FloatingActionButton(
                    backgroundColor: _isRecording ? Colors.red : Colors.green,
                    onPressed: _isRecording ? stop : start,
                    child: _isRecording ? Icon(Icons.stop) : Icon(Icons.mic)),
              ),
              ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                  padding: EdgeInsets.all(140),
                  margin: EdgeInsets.all(5),
                  ),
                ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: EdgeInsets.all(80),
                        margin: EdgeInsets.all(5),
                          child: Text(Translations.of(context).text('measuredDB') + " db: " + _meanDecibelLevel.split(".")[0],
                              style: TextStyle(fontSize: 20, color: Colors.black)),
                      )
                  )
                ]
            )
        ),

      ),
    );
  }
}

Widget _buildPopupDialog1(BuildContext context, var average) {
  int _newAverage;
  try {
    _newAverage = average.round();
  } catch (UnsupportedError) {
    Navigator.of(context).pop();
  }
  return new AlertDialog(
    title: Text(Translations.of(context).text('noiseMeasure')),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(_newAverage.toString() + " db",
            style: TextStyle(
              fontSize: 20.0,
            )),
      ],
    ),
    actions: <Widget>[
      new TextButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) =>
                _buildPopupDialog2(context, _newAverage),
          );
        },
        child: Text(Translations.of(context).text('save')),
      ),
      new TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text(Translations.of(context).text('close')),
      ),
    ],
  );
}

Widget _buildPopupDialog2(BuildContext context, int averageToSave) {
  String name = "";
  return new AlertDialog(
    title: Text(Translations.of(context).text('noiseSave')),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextField(
            onChanged: (value) {
              name = value;
            },
            style: TextStyle(
              fontSize: 20.0,
            )),
      ],
    ),
    actions: <Widget>[
      new TextButton(
        onPressed: () {
          if (name == "") {
            name = "Untitled";
          }
        },
        child: TextButton(
          child: Text(Translations.of(context).text('save')),
          onPressed: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
            addNoise(name, averageToSave);
            showDialog(
                context: context,
                builder: (BuildContext context) => successText(context));
          },
        ),
      ),
      new TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text(Translations.of(context).text('close')),
      ),
    ],
  );
}

Widget successText(context) {
  return AlertDialog(
      title: Text(Translations.of(context).text('successSave')),
  content: Container(
     child : TextButton(
     onPressed: () {
     return Navigator.of(context).pop();
     },
     child: Text(Translations.of(context).text('close')),
   ),));
}

void addNoise(String name, int averageToSave) {
  AddFavorite addFavorite = AddFavorite(
       FavoriteAddress(
          address: name, location: "", decibel: averageToSave.toString()), false);
  addFavorite.add();
}
