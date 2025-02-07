import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:healer_user/bloc/therapist/therapist_bloc.dart';
import 'package:healer_user/view/therapist/widgets/therapist_card.dart';
import 'package:healer_user/view/therapist/widgets/therapist_detail.dart';
import 'package:healer_user/view/widgets/empty.dart';
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
              child: Empty(
            title: 'Waiting for a Response',
            subtitle:
                "Once you’ve sent a request to a therapist. Once they accept, you’ll see them here. Hang tight!",
            image: 'asset/emptyPending.jpg',
          ));
        } else if (state is RequestStatusLoaded) {
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
                  status: status,
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
