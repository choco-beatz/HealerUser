import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healer_user/bloc/registeration/registeration_bloc.dart';
import 'package:healer_user/constants/snackbar.dart';
import 'package:healer_user/view/appointment/screens/appointment_therapist.dart';
import 'package:healer_user/view/homescreen/widgets/appointment.dart';
import 'package:healer_user/view/homescreen/widgets/drawer.dart';
import 'package:healer_user/view/homescreen/widgets/home_app_bar.dart';
import 'package:healer_user/view/homescreen/widgets/menu_card.dart';
import 'package:healer_user/view/login/login.dart';
import 'package:healer_user/view/therapist/view_therapist.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<RegisterationBloc>().add(CheckTokenEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          drawer: const DrawerWidget(),
          body: BlocListener<RegisterationBloc, RegisterationState>(
            listener: (context, state) {
              log('redirect: ${state.redirect.toString()}');
              if (state.redirect == true) {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              }
              if (state.hasError) {
                ScaffoldMessenger.of(context).showSnackBar(somethingWentWrong);
              }
            },
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  HomeAppBar(height: height, width: width),
                  AppointmentToday(height: height),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ViewTherapist()));
                              },
                              child: MenuCard(
                                width: width,
                                image: 'asset/psychology.png',
                                title: 'Therapists',
                              ),
                            ),
                            InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AppointmentTherapist())),
                              child: MenuCard(
                                width: width,
                                image: 'asset/appointment.png',
                                title: 'Appointment',
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            MenuCard(
                              width: width,
                              image: 'asset/chat1.png',
                              title: 'Chat',
                            ),
                            MenuCard(
                              width: width,
                              image: 'asset/call.png',
                              title: 'Calls',
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
