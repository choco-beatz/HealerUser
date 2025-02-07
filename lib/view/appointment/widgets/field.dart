import 'package:flutter/material.dart';
import 'package:healer_user/constants/colors.dart';
import 'package:healer_user/constants/textstyle.dart';
import 'package:healer_user/view/widgets/textfield.dart';

Widget buildField({
  required String label,
  required String initialValue,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      SizedBox(
        child: TextFormField(
          initialValue: initialValue,
          
          decoration: textField(initialValue),
          cursorColor: textColor,
          style: textFieldStyle,
        ),
      ),
    ],
  );
}
