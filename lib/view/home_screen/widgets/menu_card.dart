import 'package:flutter/material.dart';
import 'package:healer_user/constants/colors.dart';
import 'package:healer_user/constants/space.dart';

class MenuCard extends StatelessWidget {
  const MenuCard({
    super.key,
    required this.width,
    required this.image,
    required this.title,
    required this.subtitle,
  });

  final double width;
  final String subtitle;
  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: white,
      child: SizedBox(
        width: width * 0.9,
        height: width * 0.28,
        child: Row(
          children: [
            Image.asset(height: 100, width: 80, image),
            space,
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      color: main2, fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                      color: main1, fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
