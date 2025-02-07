import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:healer_user/constants/space.dart';
import 'package:healer_user/constants/textstyle.dart';

class Empty extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  const Empty(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: Image.asset(height: 150, image)),
          space,
          space,
          Text(
            textAlign: TextAlign.center,
            title,
            style: semiBold,
          ),
          Text(
            textAlign: TextAlign.center,
            subtitle,
            style: textFieldStyle,
          ),
          space,
          space,
        ],
      ),
    );
  }
}
