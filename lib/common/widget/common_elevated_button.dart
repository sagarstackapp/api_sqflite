import 'package:flutter/material.dart';

Widget commonElevatedButton(
    {String text, Color textColor, Color buttonColor, VoidCallback onPressed}) {
  return Container(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Text(
          text ?? 'Enter Name',
          style: TextStyle(
            fontSize: 15,
            color: textColor,
          ),
        ),
      ),
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(buttonColor),
      ),
    ),
  );
}
