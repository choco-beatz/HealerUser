import 'package:flutter/material.dart';
import 'package:healer_user/constants/colors.dart';
import 'package:healer_user/constants/space.dart';
import 'package:healer_user/constants/textstyle.dart';
import 'package:healer_user/model/therapist_model/therapist_model.dart';
import 'package:healer_user/view/appointment/appointment.dart';
import 'package:healer_user/view/appointment/widgets/build_button.dart';

class TherapistCard extends StatelessWidget {
  const TherapistCard({
    super.key,
    required this.therapist,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;
  final TherapistModel therapist;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        color: white,
        child: SizedBox(
            height: height * 0.14,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: CircleAvatar(
                        backgroundColor: transparent,
                        radius: width * 0.14,
                        child: (therapist.image.split('.').last == 'png')
                            ? Image.network(
                                fit: BoxFit.fitHeight,
                                therapist.image,
                                width: 80,
                                height: 80,
                              )
                            : ClipOval(
                                child: Image.network(
                                  fit: BoxFit.fitHeight,
                                  therapist.image,
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
                      Text(therapist.profile.name, style: smallBold),
                      smallSpace,
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>  Appointment( therapistId: therapist.id,)));
                          },
                          child: buildButton(text: "Book Appointment")),
                      smallSpace,
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
