import 'package:flutter/material.dart';
import 'package:healer_user/constants/colors.dart';
import 'package:healer_user/constants/gradient.dart';
import 'package:healer_user/constants/space.dart';
import 'package:healer_user/constants/textstyle.dart';
import 'package:healer_user/model/appointment_model/appointment_model.dart';
import 'package:healer_user/view/appointment/widgets/payment_alert.dart';
import 'package:intl/intl.dart';

class AppointmentTherapistCard extends StatelessWidget {
  const AppointmentTherapistCard({
    super.key,
    required this.appointment,
    required this.height,
    required this.status,
    required this.width,
  });

  final double height;
  final String status;
  final double width;
  final AppointmentModel appointment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: white,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: CircleAvatar(
                      backgroundColor: transparent,
                      radius: width * 0.14,
                      backgroundImage:
                          NetworkImage(appointment.therapist.image),
                    ),
                  ),
                  hSpace, // Added spacing
                  Expanded(
                    // Expands the text column so it doesn’t overflow
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appointment.therapist.profile.name,
                          style: smallBold,
                          overflow: TextOverflow.ellipsis, // Prevents overflow
                        ),
                        smallSpace,
                        Text(
                          DateFormat('dd MMMM yyyy')
                              .format(DateTime.parse(appointment.date)),
                          style: textFieldStyle,
                        ),
                        smallSpace,
                        FittedBox(
                          child: Chip(
                            side: BorderSide.none,
                            backgroundColor: main1trans,
                            label: Text(
                              '${appointment.startTime} - ${appointment.endTime}',
                              style: colorTextStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (status != 'confirmed')
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    height: 46,
                    width: double.infinity, // Makes it responsive
                    decoration: BoxDecoration(
                      gradient: gradient,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: status == 'accepted'
                          ? InkWell(
                              onTap: () {
                                showPaymentSlotDialog(appointment.id,
                                    appointment.amount, context);
                              },
                              child: const Text(
                                'Tap to Proceed with Payment',
                                style: TextStyle(
                                    color: white,
                                    fontSize: 18, // Slightly reduced size
                                    fontWeight: FontWeight.w600),
                              ),
                            )
                          : const Text(
                              "Waiting for Therapist's Approval",
                              style: TextStyle(
                                  color: white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
