import 'package:flutter/material.dart';
import 'package:healer_user/constants/space.dart';
import 'package:healer_user/constants/textstyle.dart';

class Onboadrd extends StatelessWidget {
  const Onboadrd({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Welcome Onboard', style: bigBold),
        const Text('We are here to help you', style: textFieldStyle),
        space,
        Image.asset(height: 100, 'asset/happy.png'),
        space,
        space
      ],
    );
  }
}
