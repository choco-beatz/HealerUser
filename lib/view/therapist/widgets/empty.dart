import 'package:flutter/material.dart';
import 'package:healer_user/constants/space.dart';
import 'package:healer_user/constants/textstyle.dart';

class EmptyTherapist extends StatelessWidget {
  final String description;
  const EmptyTherapist({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(height: 150, 'asset/empty.png'),
          space,
          space,
          Text(
            textAlign: TextAlign.center,
            description,
            style: semiBold,
          ),
          space,
          space,
        ],
      ),
    );
  }
}
