
import 'package:flutter/material.dart';
import 'package:healer_user/constants/colors.dart';
import 'package:healer_user/constants/space.dart';
import 'package:healer_user/constants/textstyle.dart';

class MenuCard extends StatelessWidget {
  const MenuCard({
    super.key,
    required this.width, required this.image, required this.title,
  });

  final double width;
  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: white,
      child: SizedBox(
        width: width * 0.45,
        height: width * 0.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: main2trans,
              child: Image.asset(height: 60, image),
            ),
            space,
            Text(
              title,
              style: boldTextFieldStyle,
            )
          ],
        ),
      ),
    );
  }
}
