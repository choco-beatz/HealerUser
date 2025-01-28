import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healer_user/bloc/appointment/appointment_bloc.dart';
import 'package:healer_user/constants/colors.dart';
import 'package:healer_user/constants/textstyle.dart';
import 'package:healer_user/model/appointment_model/appointment_model.dart';
import 'package:healer_user/view/appointment/widgets/appoinment_therapist_card.dart';

class AppointmentToday extends StatelessWidget {
  const AppointmentToday({
    super.key,
    required this.height,
    required this.width,
    required this.appointments,
  });

  final double height;
  final double width;
  final List<AppointmentModel> appointments;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (appointments.isEmpty) {
        context.read<AppointmentBloc>().add(SlotStatusEvent(status: 'confirmed'));
      }
    });

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Today's Appointments",
            style: smallXBold,
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: appointments.length,
            itemBuilder: (context, index) {
              final appointment = appointments[index];
              return AppointmentTherapistCard(
                appointment: appointment,
                height: height,
                status: 'Confirmed',
                width: width,
              );
            },
          ),
          const Divider(
            color: fieldBG,
          ),
        ],
      ),
    );
  }
}
