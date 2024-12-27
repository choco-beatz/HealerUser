import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healer_user/bloc/appointment/appointment_bloc.dart';
import 'package:healer_user/constants/colors.dart';
import 'package:healer_user/view/appointment/widgets/appoinment_therapist_card.dart';
import 'package:healer_user/view/appointment/widgets/therapist_detail.dart';
import 'package:healer_user/view/therapist/widgets/empty.dart';

class AppointmentStatus extends StatelessWidget {
  final String status;
  const AppointmentStatus({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppointmentBloc>().add(SlotStatusEvent(status: status));
    });

    return Scaffold(
      body: BlocBuilder<AppointmentBloc, AppointmentState>(
        builder: (context, state) {
          final appointment = state.appointments;
          if (appointment.isEmpty) {
            return const Center(
              child: EmptyTherapist(),
            );
          }
          return ListView.builder(
              itemCount: appointment.length,
              itemBuilder: (context, index) {
                final therapist = appointment[index];

                return GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TherapistDetails(
                                therapist: therapist.therapist))),
                    child: AppointmentTherapistCard(
                      height: height,
                      status: status,
                      width: width,
                      appointment: therapist,
                    ));
              });
        },
      ),
    );
  }
}
