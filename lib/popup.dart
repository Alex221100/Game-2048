import 'package:flutter/material.dart';

class Popup {
  static Future<void> showMyPopup(parentContext) {
    return showDialog(
      context: parentContext,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          content: Container(
            height: 450,
            width: 400,
            child: Image.asset(
  "../assets/gameover.gif",
  height: 125.0,
  width: 125.0,
),
          ),
        );
      },
    );
  }
}