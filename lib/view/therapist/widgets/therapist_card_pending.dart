
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healer_user/bloc/therapist/therapist_bloc.dart';
import 'package:healer_user/constants/colors.dart';
import 'package:healer_user/constants/space.dart';
import 'package:healer_user/constants/textstyle.dart';
import 'package:healer_user/model/therapist_model/therapist_model.dart';
import 'package:healer_user/view/therapist/widgets/request_button.dart';

class TherapistCardPending extends StatelessWidget {
  const TherapistCardPending({
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
            height: height * 0.18,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: CircleAvatar(
                        backgroundColor: transparent,
                        radius: width * 0.145,
                        child: (therapist.image!.split('.').last == 'png')
                            ? Image.network(
                                fit: BoxFit.fitHeight,
                                therapist.image!,
                                width: 110,
                                height: 110,
                              )
                            : ClipOval(
                                child: Image.network(
                                  fit: BoxFit.fitHeight,
                                  therapist.image!,
                                  width: 110,
                                  height: 110,
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
                    InkWell(
                              onTap: () {
                                      context.read<TherapistBloc>().add(
                                          RequestSentEvent(
                                              therapistId: therapist.id));
                                    },
                              child: buildButton(
                                  text: "Pending"))
                    ])
                ),
              ],
            )),
      ),
    );
  }
}
