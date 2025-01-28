// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:healer_user/bloc/therapist/therapist_bloc.dart';
import 'package:healer_user/view/therapist/widgets/empty.dart';
import 'package:healer_user/view/therapist/widgets/therapist_card_ongoing.dart';
import 'package:healer_user/view/therapist/widgets/therapist_card_pending.dart';
import 'package:healer_user/view/widgets/loading.dart';

class RequestStatusPage extends StatelessWidget {
  final String status;
  const RequestStatusPage({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return BlocBuilder<TherapistBloc, TherapistState>(
      builder: (context, state) {
        if (state is TherapistLoading) {
          return const Loading();
        } else if (state is TherapistError) {
          return Center(child: Text(state.message));
        } else if (state is RequestStatusLoaded && state.list.isEmpty) {
          return const Center(
              child: EmptyTherapist(description: 'No one is here'));
        } else if (state is RequestStatusLoaded) {
          return ListView.builder(
            itemCount: state.list.length,
            itemBuilder: (context, index) {
              final therapist = state.list[index];
              return GestureDetector(
                onTap: () {
                  // Navigate to details
                },
                child: status == "Accepted"
                    ? TherapistCardOngoing(
                        therapist: therapist, height: height, width: width)
                    : TherapistCardPending(
                        height: height,
                        width: width,
                        therapist: therapist,
                      ),
              );
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}
