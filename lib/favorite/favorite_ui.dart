import 'package:flutter/material.dart';

class FavoriteUi {
  Text locationText(String subtitle) {
    return Text(
      ' ' + subtitle,
      style: TextStyle(
        fontSize: 17,
      ),
    );
  }

  Text addressText(String address) {
    return Text(
      address,
      style: TextStyle(
        fontSize: 20,
        height: 3,
      ),
    );
  }

  Widget trailingDecibel(String decibel, bool isMap, context) {
    if (!isMap) {
      return Text(
        (decibel + ' db'),
        style: TextStyle(
          color: _buildColors(int.parse(decibel)),
          fontSize: 20,
        ),
      );
    } else
      return Padding(
            padding: EdgeInsets.only(top: 10),

              child: MaterialButton(
                shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(22.0) ),
                height: 35.0,
                minWidth: 30.0,
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                child: new  Text(
                  (_buildDecibelForMap(int.parse(decibel) ) +   " db"),
                  style: TextStyle(
                    color: _buildColors(int.parse(decibel)),
                    fontSize: 20,
                  ),
                ),
                // Go to Map
                onPressed: () => {},
                splashColor: Colors.white,
              ),
      );
  }

  String _buildDecibelForMap(int decibelValue) {
    if (decibelValue >= 0 && decibelValue <= 39) return "0 - 40";
    if (decibelValue >= 40 && decibelValue <= 44) return "40 - 45";
    if (decibelValue >= 45 && decibelValue <= 49) return "45 - 50";
    if (decibelValue >= 50 && decibelValue <= 54) return "50 - 55";
    if (decibelValue >= 55 && decibelValue <= 59) return "55 - 60";
    if (decibelValue >= 60 && decibelValue <= 64) return "60 - 65";
    if (decibelValue >= 65 && decibelValue <= 69) return "65 - 70";
    if (decibelValue >= 70 && decibelValue <= 74)
      return "70 - 75";
    else
      return "75+";
  }

  Color _buildColors(int decibelValue) {
    if (decibelValue >= 0 && decibelValue <= 39) return Colors.grey;
    if (decibelValue >= 40 && decibelValue <= 44) return Colors.blue[300];
    if (decibelValue >= 45 && decibelValue <= 49) return Colors.blue;
    if (decibelValue >= 50 && decibelValue <= 54) return Colors.lightGreen;
    if (decibelValue >= 55 && decibelValue <= 59) return Colors.green;
    if (decibelValue >= 60 && decibelValue <= 64) return Colors.yellow;
    if (decibelValue >= 65 && decibelValue <= 69) return Colors.orange;
    if (decibelValue >= 70 && decibelValue <= 74)
      return Colors.deepOrange;
    else
      return Colors.red;
  }
}
