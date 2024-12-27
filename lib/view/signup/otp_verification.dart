import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:healer_user/bloc/registeration/registeration_bloc.dart';
import 'package:healer_user/constants/snackbar.dart';
import 'package:healer_user/constants/space.dart';
import 'package:healer_user/constants/textstyle.dart';
import 'package:healer_user/view/login/login.dart';
import 'package:healer_user/view/signup/widgets/otp.dart';
import 'package:healer_user/view/signup/widgets/otp_field.dart';
import 'package:healer_user/view/widgets/button.dart';

class Otpscreen extends StatelessWidget {
  final String email;
  const Otpscreen({
    super.key,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    final List<TextEditingController> controllers =
        List.generate(6, (_) => TextEditingController());
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: BlocListener<RegisterationBloc, RegisterationState>(
            listener: (context, state) {
              if (state.resentOtp == true) {
                ScaffoldMessenger.of(context).showSnackBar(otpResent);
              }

              if (state.isSuccess == true&& state.isVerified==true) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginScreen()));
              } else {
                log('failed');
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Otp(),
                space,
                OtpField(
                  controllers: controllers,
                ),
                space,
                InkWell(
                  onTap: () {
                    List<String> otpString = [];
                    for (var controller in controllers) {
                      otpString.add(controller.text);
                    }
                    context.read<RegisterationBloc>().add(
                        VerifyOTPEvent(otp: otpString.join(''), email: email));
                  },
                  child: const Button(text: 'Verify'),
                ),
                InkWell(
                  onTap: () {
                    context
                        .read<RegisterationBloc>()
                        .add(ResentOTPEvent(email: email));
                        
                  },
                  child: const Text(
                    'Resend OTP?',
                    style: textFieldStyle,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
