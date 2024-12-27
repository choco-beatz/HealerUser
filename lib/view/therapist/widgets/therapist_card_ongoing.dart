import 'package:flutter/material.dart';
import 'package:healer_user/constants/colors.dart';
import 'package:healer_user/constants/space.dart';
import 'package:healer_user/constants/textstyle.dart';
import 'package:healer_user/model/therapistmodel/therapist_model.dart';

class TherapistCardOngoing extends StatelessWidget {
  const TherapistCardOngoing({
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
      padding: const EdgeInsets.only(top: 10),
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
                        child: (therapist.image!.split('.').last == 'png')
                            ? Image.network(
                                fit: BoxFit.fitHeight,
                                therapist.image!,
                                width: 80,
                                height: 80,
                              )
                            : ClipOval(
                                child: Image.network(
                                  fit: BoxFit.fitHeight,
                                  therapist.image!,
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
                      Text(therapist.name, style: smallBold),
                      Text(
                        therapist.qualification,
                        style: const TextStyle(color: main1),
                      ),
                      Text(
                        therapist.specialization,
                        style: const TextStyle(fontSize: 14, color: textColor),
                      ),
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
