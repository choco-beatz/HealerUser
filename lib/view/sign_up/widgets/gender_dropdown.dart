import 'package:flutter/material.dart';
import 'package:healer_user/constants/colors.dart';
import 'package:healer_user/constants/textstyle.dart';
import 'package:healer_user/view/widgets/textfield.dart';

Widget buildDropdownField({
  required String label,
  required String? value,
  required Function(String?) onChanged,
  String? Function(String?)? validator,
  String hint = 'Select Gender',
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      SizedBox(
        height: 55,
        child: DropdownButtonFormField<String>(
          value: value,
          items: const [
            DropdownMenuItem(value: 'male', child: Text('Male')),
            DropdownMenuItem(value: 'female', child: Text('Female')),
            DropdownMenuItem(value: 'other', child: Text('Other')),
          ],
          onChanged: onChanged,
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: textField(hint),
          style: textFieldStyle,
          dropdownColor: white,
          isExpanded: true,
        ),
      ),
    ],
  );
}