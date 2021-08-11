import 'package:api_sqflite/common/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget commonTextFormField({
  TextEditingController controller,
  IconData icon,
  String hint,
  TextInputType keyboardType,
  List<TextInputFormatter> inputFormatters,
  bool autoFocus = false,
}) {
  return Container(
    margin: EdgeInsets.only(top: 30, left: 10, right: 10),
    height: 50,
    width: double.infinity,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: ColorResources.LightBlue),
    ),
    child: TextField(
      textAlign: TextAlign.start,
      controller: controller,
      autofocus: autoFocus,
      keyboardType: keyboardType ?? TextInputType.number,
      inputFormatters: inputFormatters,
      style: TextStyle(color: Colors.black, fontSize: 16),
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.person),
        border: InputBorder.none,
        hintText: hint ?? 'Enter Hint Text',
        hintStyle: TextStyle(
          color: ColorResources.LightBlue,
          fontSize: 16,
          fontFamily: 'JetBrains',
        ),
      ),
    ),
  );
}
