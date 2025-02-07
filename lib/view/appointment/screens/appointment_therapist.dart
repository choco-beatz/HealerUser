import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healer_user/bloc/therapist/therapist_bloc.dart';
import 'package:healer_user/constants/colors.dart';
import 'package:healer_user/view/appointment/widgets/therapist_card.dart';
import 'package:healer_user/view/widgets/empty.dart';
import 'package:healer_user/view/widgets/loading.dart';

class AppointmentTherapist extends StatelessWidget {
  const AppointmentTherapist({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TherapistBloc>().add(RequestStatusEvent(status: "Accepted"));
    });

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          backgroundColor: white,
          elevation: 0,
          title: const Text(
            'Appointment',
            style: TextStyle(color: black),
          ),
        ),
      ),
      body:
          BlocBuilder<TherapistBloc, TherapistState>(builder: (context, state) {
        if (state is TherapistLoading) {
          return const Loading();
        } else if (state is RequestStatusLoaded) {
          final therapists = state.list;
          if (therapists.isEmpty) {
            return const Center(
              child: Empty(
                title:
                    "Explore Our Therapists",
                    subtitle: 'Browse through our list of available therapists and choose the one that’s right for you. Book your appointment today!',
                    image: 'asset/emptyAppointment.jpg',
              ),
            );
          }
          return ListView.builder(
              itemCount: therapists.length,
              itemBuilder: (context, index) {
                final therapist = therapists[index];

                return  TherapistCard(
                      height: height,
                      width: width,
                      therapist: therapist,
                    );
              });
        } else {
          return const SizedBox.shrink();
        }
      }),
    );
  }
}
