import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healer_user/bloc/therapist/therapist_bloc.dart';
import 'package:healer_user/view/therapist/widgets/therapist_card.dart';
import 'package:healer_user/view/therapist/widgets/therapist_detail.dart';
import 'package:healer_user/view/widgets/empty.dart';
import 'package:healer_user/view/widgets/loading.dart';

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
              child: Empty(
            title: 'No Therapists Available',
            subtitle:
                'It looks like there are no therapists to send a request to right now. Check back later for available professionals!',
            image: 'asset/emptyTherapist.jpg',
          ));
        } else if (state is TherapistLoaded) {
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
              ),
              itemCount: state.list.length,
              itemBuilder: (context, index) {
                final therapist = state.list[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                TherapistDetails(therapist: therapist)));
                  },
                  child: TherapistCard(
                    width: width,
                    therapist: therapist,
                    height: height,
                  ),
                );
              });
        }
        return state is TherapistLoaded
            ? GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                ),
                itemCount: state.list.length,
                itemBuilder: (context, index) {
                  final therapist = state.list[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  TherapistDetails(therapist: therapist)));
                    },
                    child: TherapistCard(
                      width: width,
                      height: height,
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
