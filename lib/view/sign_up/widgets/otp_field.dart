// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:healer_user/view/widgets/textfield.dart';

class OtpField extends StatelessWidget {
  final List<TextEditingController> controllers;
  const OtpField({
    super.key,
    required this.controllers,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(6, (index) {
        return Field(controller: controllers[index]);
      }),
    );
  }
}

class Field extends StatelessWidget {
  final TextEditingController controller;
  const Field({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: SizedBox(
        height: 55,
        width: 45,
        child: TextFormField(
          controller: controller,
          onChanged: (value) {
            if (value.isNotEmpty) {
              FocusScope.of(context).nextFocus();
            } else if (value.isEmpty) {
              FocusScope.of(context).previousFocus();
            }
          },
          textAlign: TextAlign.center,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.digitsOnly
          ],
          decoration: textField(''),
        ),
      ),
    );
  }
}
