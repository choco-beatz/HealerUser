import 'package:flutter/material.dart';
import 'package:healer_user/constants/space.dart';
import 'package:healer_user/constants/textstyle.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Welcome Back', style: bigBold),
        space,
        Image.asset(height: 100, 'asset/welcome.png'),
        space,
        space
      ],
    );
  }
}
