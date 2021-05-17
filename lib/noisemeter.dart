import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:noise_meter/noise_meter.dart';

class NoiseMeterApp extends StatefulWidget {
  @override
  _NoiseMeterState createState() => _NoiseMeterState();
}

class _NoiseMeterState extends State<NoiseMeterApp> {
  bool _isRecording = false;
  StreamSubscription<NoiseReading> _noiseSubscription;
  NoiseMeter _noiseMeter;
  String _maxDecibelLevel = "No reading.";
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
    print(noiseReading.toString());
    _maxDecibelLevel = noiseReading.maxDecibel.toString();
    _meanDecibelLevel = noiseReading.meanDecibel.toString();
    _decibelreadings.add(noiseReading.maxDecibel);
  }

  void onError(PlatformException e) {
    print(e.toString());
    _isRecording = false;
  }

  void start() async {
    try {
      _noiseSubscription = _noiseMeter.noiseStream.listen(onData);
    } catch (err) {
      print(err);
    }
  }

  void stop() async {
    try {
      if (_noiseSubscription != null) {
        _noiseSubscription.cancel();
        _noiseSubscription = null;
      }
      this.setState(() {
        this._isRecording = false;
      });
      _decibelreadings.forEach((element) {
        _totaldecibel += element;
      });
      _averagedecibel = _totaldecibel / _decibelreadings.length;
    } catch (err) {
      print('stopRecorder error: $err');
    }
  }

  List<Widget> getContent() => <Widget>[
    Container(
        margin: EdgeInsets.all(25),
        child: Column(children: [
          Container(
            child: Text(_isRecording ? "Mic: ON" : "Mic: OFF",
                style: TextStyle(fontSize: 25, color: Colors.black)),
            margin: EdgeInsets.only(top: 20),
          ),
          Container(child: Text("Max db: " + _maxDecibelLevel)),
          Container(child: Text("Mean db: " + _meanDecibelLevel)),
          Container(child: Text("Final average db reading: " + _averagedecibel.toString())),
        ]))
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: getContent())),
        floatingActionButton: FloatingActionButton(
            backgroundColor: _isRecording ? Colors.red : Colors.green,
            onPressed: _isRecording ? stop : start,
            child: _isRecording ? Icon(Icons.stop) : Icon(Icons.mic)),
      ),
    );
  }
}
