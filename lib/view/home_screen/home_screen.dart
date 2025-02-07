import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healer_user/bloc/agora/agora_bloc.dart';
import 'package:healer_user/bloc/appointment/appointment_bloc.dart';
import 'package:healer_user/bloc/chat/chat_bloc.dart';
import 'package:healer_user/bloc/registeration/registeration_bloc.dart';
import 'package:healer_user/bloc/user/user_bloc.dart';
import 'package:healer_user/constants/colors.dart';
import 'package:healer_user/constants/snackbar.dart';
import 'package:healer_user/main.dart';
import 'package:healer_user/services/chat/socket.dart';
import 'package:healer_user/services/user/user_id.dart';
import 'package:healer_user/view/appointment/screens/appointment_therapist.dart';
import 'package:healer_user/view/call/widgets/incoming_call_dialog.dart';
import 'package:healer_user/view/chat/screens/inbox.dart';
import 'package:healer_user/view/home_screen/widgets/todays_appointment.dart';
import 'package:healer_user/view/home_screen/widgets/drawer.dart';
import 'package:healer_user/view/home_screen/widgets/home_app_bar.dart';
import 'package:healer_user/view/home_screen/widgets/menu_card.dart';
import 'package:healer_user/view/login/login.dart';
import 'package:healer_user/view/therapist/view_therapist.dart';
import 'package:healer_user/view/widgets/loading.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SocketService socketService = SocketService();
  String? userId;

  @override
  void initState() {
    context.read<RegisterationBloc>().add(CheckTokenEvent());
    _initializeSocket();
    context.read<AgoraBloc>().add(GetToken());
    super.initState();
  }

  void _initializeSocket() async {
  userId = await getUserId();

  if (userId != null) {
    socketService.initialize(userId: userId!);
  } else {
    log('UserId is null. Socket initialization skipped.');
  }

  socketService.listenToEvent('incoming-call', (data) {
    final ctx = navigatorKey.currentState?.overlay?.context;

    if (ctx != null) {
      Navigator.push(
        ctx,
        MaterialPageRoute(
          builder: (context) => IncomingCallScreen(
            callerId: data['from']?['userId'],
            callerName: data['from']?['name'] ?? 'Unknown',
            callerImage: data['from']?['image'],
            socketService: socketService,
            userId: userId!,
          ),
        ),
      );
    } else {
      log('Context is null. Cannot navigate to IncomingCallScreen.');
    }
  });
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
                  BlocProvider(
                    create: (context) => UserBloc()..add(GetProfileEvent()),
                    child: HomeAppBar(height: height, width: width),
                  ),
                  BlocBuilder<AppointmentBloc, AppointmentState>(
                    builder: (context, state) {
                      if (state is AppointmentLoading) {
                        return const Loading();
                      } else if (state is AppointmentsLoaded) {
                        final String today =
                            DateFormat('yyyy-MM-dd').format(DateTime.now());
                        final todayAppointments =
                            state.appointments.where((appointment) {
                          return appointment.date == today &&
                              appointment.status == 'confirmed';
                        }).toList();

                        if (todayAppointments.isNotEmpty) {
                          return AppointmentToday(
                            height: height,
                            width: width,
                            appointments: todayAppointments,
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      } else if (state is AppointmentError) {
                        return Center(
                          child: Text(state.errorMessage,
                              style: const TextStyle(color: red)),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ViewTherapist()));
                        },
                        child: MenuCard(
                          width: width,
                          image: 'asset/psychology.png',
                          title: 'Therapists',
                          subtitle: 'Explore Qualified Therapists',
                        ),
                      ),
                      InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const AppointmentTherapist())),
                        child: MenuCard(
                          width: width,
                          image: 'asset/appointment.png',
                          title: 'Appointment',
                          subtitle: 'Book Your Appointments Here',
                        ),
                      ),
                      InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MultiBlocProvider(
                                    providers: [
                                      BlocProvider(
                                        create: (context) =>
                                            ChatBloc()..add(LoadChatsEvent()),
                                      ),
                                    ],
                                    child: Inbox(
                                      socketService: socketService,
                                    ),
                                  )),
                        ),
                        child: MenuCard(
                          width: width,
                          image: 'asset/chat1.png',
                          title: 'Chat',
                          subtitle: 'Chat with Your Therapist',
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
