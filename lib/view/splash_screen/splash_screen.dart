import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healer_user/bloc/registeration/registeration_bloc.dart';
import 'package:healer_user/constants/colors.dart';
import 'package:healer_user/constants/gradient.dart';
import 'package:healer_user/view/home_screen/home_screen.dart';
import 'package:healer_user/view/login/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      context.read<RegisterationBloc>().add(CheckTokenEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: BlocListener<RegisterationBloc, RegisterationState>(
        listener: (context, state) {
          log('${state.tokenValid.toString()}${state.redirect.toString()}');
          if (!state.tokenValid || state.redirect) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          }
          if (state.tokenValid) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          }
        },
        child: Container(
            height: height,
            width: width,
            decoration: const BoxDecoration(gradient: gradient),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(height: 150, 'asset/treatment.png'),
                Text('Healer',
                    style: GoogleFonts.satisfy(
                      textStyle: const TextStyle(color: white, fontSize: 50),
                    ))
              ],
            )),
      ),
    );
  }
}
