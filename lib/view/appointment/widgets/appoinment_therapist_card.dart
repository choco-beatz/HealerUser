import 'package:flutter/material.dart';
import 'package:healer_user/constants/colors.dart';
import 'package:healer_user/constants/gradient.dart';
import 'package:healer_user/constants/space.dart';
import 'package:healer_user/constants/textstyle.dart';
import 'package:healer_user/model/appointmentmodel/appointment_model.dart';
import 'package:healer_user/view/appointment/widgets/payment_alert.dart';

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
        color: white,
        child: SizedBox(
            height: height * 0.22,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: CircleAvatar(
                            backgroundColor: transparent,
                            radius: width * 0.14,
                            child:
                                (appointment.therapist.image.split('.').last ==
                                        'png')
                                    ? Image.network(
                                        fit: BoxFit.fitHeight,
                                        appointment.therapist.image,
                                        width: 80,
                                        height: 80,
                                      )
                                    : ClipOval(
                                        child: Image.network(
                                          fit: BoxFit.fitHeight,
                                          appointment.therapist.image,
                                          width: 80,
                                          height: 80,
                                        ),
                                      ))),
                    SizedBox(
                      width: width * 0.62,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          smallSpace,
                          Text(appointment.therapist.profile.name,
                              style: smallBold),
                          smallSpace,
                          Text(appointment.date, style: textFieldStyle),
                          smallSpace,
                          Chip(
                            side: BorderSide.none,
                            backgroundColor: main1trans,
                            label: Text(
                                '${appointment.startTime} - ${appointment.endTime}',
                                style: colorTextStyle),
                          ),
                          smallSpace,
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 46,
                  width: width * 0.9,
                  decoration: BoxDecoration(
                      gradient: gradient,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: status == 'accepted'
                        ? InkWell(
                            onTap: () {
                              showPaymentSlotDialog(
                                  appointment.id, appointment.amount, context);
                            },
                            child: const Text(
                              'PROCEED TO PAYMENT',
                              style: TextStyle(
                                  color: white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        : Text(
                            status.toUpperCase(),
                            style: const TextStyle(
                                color: white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                  ),
                ),
                smallSpace,
              ],
            )),
      ),
    );
  }
}
