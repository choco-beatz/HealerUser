import 'package:flutter/material.dart';
import 'package:healer_user/constants/space.dart';
import 'package:healer_user/constants/textstyle.dart';

class Otp extends StatelessWidget {
  const Otp({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('OTP Verification', style: bigBold),
        const Text('Please check you email for OTP.', style: textFieldStyle),
        space,
        Image.asset(height: 100, 'asset/otp.png'),
        space,
        space
      ],
    );
  }
}
