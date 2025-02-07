import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healer_user/bloc/appointment/appointment_bloc.dart';
import 'package:healer_user/view/appointment/widgets/appoinment_therapist_card.dart';
import 'package:healer_user/view/widgets/empty.dart';
import 'package:healer_user/view/widgets/loading.dart';

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
        if (state is AppointmentLoading) {
          return const Loading();
        }
        if (state is AppointmentError) {
          return Center(
            child: Text(state.errorMessage),
          );
        }
        if (state is AppointmentsLoaded) {
          var appointments = state.appointments;

          // Filter appointments if status is 'confirmed'
          if (status == 'confirmed') {
            appointments = appointments.where((appointment) {
              try {
                DateTime appointmentDate = DateTime.parse(appointment.date);
                return appointmentDate.isAfter(DateTime.now());
              } catch (e) {
                return false; // Skip invalid dates
              }
            }).toList();
          }

          if (appointments.isEmpty) {
            return const Center(
              child: Empty(
                title: 'No Appointments Yet',
                subtitle:
                    'You don’t have any appointments in this category right now. Stay tuned for updates as your therapist responds, accepts, or schedules upcoming sessions!',
                image: 'asset/emptyStat.jpg',
              ),
            );
          }

          return ListView.builder(
            itemCount: appointments.length,
            itemBuilder: (context, index) {
              final therapist = appointments[index];

              return AppointmentTherapistCard(
                height: height,
                status: status,
                width: width,
                appointment: therapist,
              );
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      }),
    );
  }
}
