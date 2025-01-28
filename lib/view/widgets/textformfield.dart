import 'package:flutter/material.dart';
import 'package:healer_user/constants/colors.dart';
import 'package:healer_user/constants/textstyle.dart';
import 'package:healer_user/view/widgets/textfield.dart';

Widget buildTextFormField({
  required String label,
  bool isNumber = false,
  required TextEditingController controller,
  String? Function(String?)? validator,
  String hint = '',
  bool isMultiline = false,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      SizedBox(
        height: isMultiline ? 150 : 55,
        child: TextFormField(
          keyboardType: isNumber ? TextInputType.number : null,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          validator: validator,
          maxLines: isMultiline ? 5 : 1,
          decoration: textField(hint),
          cursorColor: textColor,
          style: textFieldStyle,
        ),
      ),
    ],
  );
}
