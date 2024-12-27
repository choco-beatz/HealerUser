import 'package:flutter/material.dart';
import 'package:healer_user/constants/colors.dart';
import 'package:healer_user/constants/gradient.dart';

class Button extends StatelessWidget {
  final String text;
  const Button({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.07,
      width: width * 0.8,
      decoration: BoxDecoration(
          gradient: gradient, borderRadius: BorderRadius.circular(15)),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
              color: white, fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

