import 'package:api_sqflite/common/constant/colors.dart';
import 'package:api_sqflite/common/constant/string.dart';
import 'package:api_sqflite/common/widget/common_elevated_button.dart';
import 'package:api_sqflite/common/widget/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget getUserDetailsField({TextEditingController controller}) {
  return commonTextFormField(
    controller: controller,
    hint: StringResources.hintText,
    inputFormatters: <TextInputFormatter>[
      FilteringTextInputFormatter.digitsOnly,
      LengthLimitingTextInputFormatter(2),
    ],
  );
}

Widget getUserDetailsButton({GestureTapCallback onTap}) {
  return commonElevatedButton(
    textColor: ColorResources.White,
    text: StringResources.buttonText,
    buttonColor: ColorResources.LightBlue,
    onPressed: onTap,
  );
}
