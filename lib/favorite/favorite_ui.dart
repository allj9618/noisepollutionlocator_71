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

  Text trailingDecibel(String decibel, bool isMap) {
    if (!isMap) {
      return Text(
        (decibel + ' db'),
        style: TextStyle(
          color: _buildColors(int.parse(decibel)),
          fontSize: 20,
          height: 3,
        ),
      );
    }
    else
      return Text(
        (decibel + ' db'),
        style: TextStyle(
          color: _buildColorsForMap(decibel),
          fontSize: 20,
          height: 3,
        ));
  }


  Color _buildColorsForMap(String decibelValue) {
    if (decibelValue == "0 - 40") return Colors.grey;
    if (decibelValue == "40 - 45") return Colors.blue[300];
    if (decibelValue == "45 - 50") return Colors.blue;
    if (decibelValue == "50 - 55") return Colors.lightGreen;
    if (decibelValue == "55 - 60") return Colors.green;
    if (decibelValue == "60 - 65") return Colors.yellow;
    if (decibelValue == "65 - 70") return Colors.orange;
    if (decibelValue == "70 - 75") return Colors.deepOrange;
    else
      return Colors.red;
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
