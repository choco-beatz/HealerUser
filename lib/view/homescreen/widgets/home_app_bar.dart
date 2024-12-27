import 'package:flutter/material.dart';
import 'package:healer_user/constants/colors.dart';
import 'package:healer_user/constants/gradient.dart';
import 'package:healer_user/constants/textstyle.dart';
import 'package:healer_user/view/homescreen/widgets/greetings.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.2,
      width: width,
      decoration: const BoxDecoration(gradient: gradient),
      child: const Padding(
        padding: EdgeInsets.all(25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Greeting(),
                Text(
                  "User Name",
                  style: bigBoldWhite,
                )
              ],
            ),
            CircleAvatar(
              backgroundColor: fieldBG,
              radius: 55,
              child: Icon(
                Icons.person_outline_sharp,
                color: main1,
                size: 50,
              ),
            )
          ],
        ),
      ),
    );
  }
}
