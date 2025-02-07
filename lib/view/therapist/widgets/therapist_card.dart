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
    required this.width,
    required this.height,
    this.status,
  });

  final double width;
  final String? status;
  final double height;
  final TherapistModel therapist;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(children: [
        // Background Image
        Container(
          height: height * 0.3,
          width: width * 0.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: NetworkImage(therapist.image),
              fit: BoxFit.cover,
              onError: (error, stackTrace) {},
            ),
          ),
        ),

        // Gradient Overlay
        Container(
          height: height * 0.3,
          width: width * 0.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [transparent, black.withOpacity(0.7)],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  therapist.profile.name,
                  style: buttonText,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  therapist.profile.specialization,
                  style: xSmallWhite,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                smallSpace,
                smallSpace,
                if (status == 'Pending')
                  buildButton(text: "Pending")
                else if (status == 'Accepted')
                  const SizedBox.shrink()
                else
                  Center(
                    child: BlocConsumer<TherapistBloc, TherapistState>(
                      listener: (context, state) {
                        if (state is RequestSentState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.message),
                              backgroundColor: state.isSuccess ? main1 : red,
                            ),
                          );
                        } else if (state is TherapistError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Error: ${state.message}"),
                              backgroundColor: red,
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is TherapistLoading) {
                          return const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: white,
                            ),
                          );
                        }
                        final isRequestSent =
                            state is RequestSentState && state.isSuccess;
                        return InkWell(
                          onTap: isRequestSent
                              ? null
                              : () {
                                  context
                                      .read<TherapistBloc>()
                                      .add(RequestSentEvent(
                                        therapistId: therapist.id,
                                      ));
                                },
                          child: buildButton(
                            text:
                                isRequestSent ? 'Request Sent' : 'Send Request',
                          ),
                        );
                      },
                    ),
                  )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
