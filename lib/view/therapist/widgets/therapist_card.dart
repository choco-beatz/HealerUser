
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healer_user/bloc/therapist/therapist_bloc.dart';
import 'package:healer_user/constants/colors.dart';
import 'package:healer_user/constants/space.dart';
import 'package:healer_user/constants/textstyle.dart';
import 'package:healer_user/model/therapist_model/therapist_model.dart';
import 'package:healer_user/view/therapist/widgets/request_button.dart';

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
                      Text(therapist.name,
                          overflow: TextOverflow.ellipsis, style: smallBold),
                      Text(
                        therapist.qualification,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: main1),
                      ),
                      Text(
                        therapist.specialization,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 14, color: textColor),
                      ),
                      smallSpace,
                      BlocConsumer<TherapistBloc, TherapistState>(
                        listener: (context, state) {
                          if (state is RequestSentState) {
                            // Show success or failure messages
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(state.message),
                              backgroundColor:
                                  state.isSuccess ? Colors.green : Colors.red,
                            ));
                          } else if (state is TherapistError) {
                            // Display error messages
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Error: ${state.message}"),
                              backgroundColor: Colors.red,
                            ));
                          }
                        },
                        builder: (context, state) {
                          // Check if the request is loading
                          if (state is TherapistLoading) {
                            return CircularProgressIndicator(); // Show loading indicator
                          }

                          // Check if the request is already sent
                          final isRequestSent =
                              state is RequestSentState && state.isSuccess;
                          return InkWell(
                            onTap: isRequestSent
                                ? null
                                : () {
                                    // Dispatch the event
                                    context
                                        .read<TherapistBloc>()
                                        .add(RequestSentEvent(
                                          therapistId: therapist.id,
                                        ));
                                  },
                            child: buildButton(
                              text: isRequestSent
                                  ? 'Request Sent'
                                  : 'Send Request',
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
