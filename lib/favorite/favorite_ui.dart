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

  Text trailingDecibel(String decibel) {
    return Text(
      (decibel + ' db'),
      style: TextStyle(
        color: _buildColors(int.parse(decibel)),
        fontSize: 20,
        height: 3,
      ),
    );
  }

  Color _buildColors(int decibelValue) {
    if (decibelValue >= 0 && decibelValue <= 53) return Colors.green;
    if (decibelValue > 53 && decibelValue <= 59) return Colors.lightGreen;
    if (decibelValue > 59 && decibelValue <= 65) return Colors.yellow;
    if (decibelValue > 65 && decibelValue <= 73)
      return Colors.orange;
    else
      return Colors.red;
  }




}