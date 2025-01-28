import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healer_user/bloc/therapist/therapist_bloc.dart';
import 'package:healer_user/view/therapist/widgets/empty.dart';
import 'package:healer_user/view/therapist/widgets/therapist_card.dart';
import 'package:healer_user/view/widgets/loading.dart';
import 'package:lottie/lottie.dart';

class AvailableTherapistsPage extends StatelessWidget {
  const AvailableTherapistsPage({super.key});

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
        } else if (state is TherapistLoaded && state.list.isEmpty) {
          return const Center(
              child: EmptyTherapist(description: 'No one is here'));
        } else if (state is TherapistLoaded) {
          return ListView.builder(
            itemCount: state.list.length,
            itemBuilder: (context, index) {
              final therapist = state.list[index];
              return GestureDetector(
                onTap: () {
                  // Navigate to details
                },
                child: TherapistCard(
                  height: height,
                  width: width,
                  therapist: therapist,
                ),
              );
            },
          );
        }
        return state is TherapistLoaded
            ? ListView.builder(
                itemCount: state.list.length,
                itemBuilder: (context, index) {
                  final therapist = state.list[index];
                  return GestureDetector(
                    onTap: () {
                      // Navigate to details (this can be implemented later)
                    },
                    child: TherapistCard(
                      height: height,
                      width: width,
                      therapist: therapist,
                    ),
                  );
                },
              )
            : const Loading();
      },
    );
  }
}
