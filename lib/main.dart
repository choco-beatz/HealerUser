import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healer_user/bloc/agora/agora_bloc.dart';
import 'package:healer_user/bloc/appointment/appointment_bloc.dart';
import 'package:healer_user/bloc/chat/chat_bloc.dart';
import 'package:healer_user/bloc/registeration/registeration_bloc.dart';
import 'package:healer_user/bloc/therapist/therapist_bloc.dart';
import 'package:healer_user/view/splash_screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
  ThemeData();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterationBloc(),
        ),
        BlocProvider(
          create: (context) => TherapistBloc(),
        ),
        BlocProvider(
          create: (context) => AppointmentBloc(),
        ),
        BlocProvider(create: (context) => AgoraBloc()),
        BlocProvider(create: (context) => ChatBloc()),
      ],
      child:
          MaterialApp(debugShowCheckedModeBanner: false, home: SplashScreen()),
    );
  }
}
