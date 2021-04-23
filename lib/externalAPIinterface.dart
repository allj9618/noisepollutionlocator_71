import 'package:flutter/material.dart';

class ExternalAPI extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('External API Test'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Maybe put some API-related thing here.',
            ),
          ],
        ),
      ),
    );
  }
  
}