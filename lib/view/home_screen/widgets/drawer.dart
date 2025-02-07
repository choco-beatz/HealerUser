import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healer_user/bloc/registeration/registeration_bloc.dart';
import 'package:healer_user/constants/colors.dart';
import 'package:healer_user/constants/gradient.dart';
import 'package:healer_user/constants/space.dart';
import 'package:healer_user/constants/textstyle.dart';
import 'package:healer_user/view/login/login.dart';
import 'package:healer_user/view/widgets/about_us.dart';
import 'package:healer_user/view/widgets/dialog_button.dart';
import 'package:healer_user/view/widgets/privacy_policy.dart';
import 'package:healer_user/view/widgets/term_and_condition.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Drawer(
        child: Column(
      children: [
        Expanded(
          child: Column(
            children: [
              Container(
                height: 150,
                width: width,
                decoration: const BoxDecoration(gradient: gradient),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      top: 50,
                      left: 100,
                      child: Text('Healer',
                          style: GoogleFonts.satisfy(
                            textStyle:
                                const TextStyle(color: white, fontSize: 70),
                          )),
                    )
                  ],
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const PrivacyPolicy()));
                },
                leading: const Icon(
                  Icons.lock_outline_rounded,
                  color: main2,
                ),
                title: const Text('Privacy policy'),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const AboutUs()));
                },
                leading: const Icon(
                  Icons.info_outlined,
                  color: main2,
                ),
                title: const Text('About Us'),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TermsAndConditions()));
                },
                leading: const Icon(
                  Icons.assignment_outlined,
                  color: main2,
                ),
                title: const Text('Terms and Conditions'),
              ),
              BlocListener<RegisterationBloc, RegisterationState>(
                  listener: (context, state) {
                    if (state.redirect == true) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => LoginScreen()));
                    }
                  },
                  child: ListTile(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                              "Log out?",
                              style: semiBold,
                            ),
                            content: const Text(
                              "Logging out? Stay safe!",
                              style: colorTextStyle,
                            ),
                            actions: [
                              GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: buildButton(text: 'Cancel')),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    context
                                        .read<RegisterationBloc>()
                                        .add(LogOutEvent());
                                  },
                                  child:
                                      buildButton(text: 'Log Out', imp: true)),
                            ],
                          );
                        },
                      );
                    },
                    leading: const Icon(
                      Icons.logout_outlined,
                      color: red,
                    ),
                    title: const Text(
                      "Log out",
                      style: TextStyle(color: red),
                    ),
                  )),
            ],
          ),
        ),
        const Text(
          'Version: 1.0.0+2',
          style: lightText,
        ),
        space
      ],
    ));
  }
}
