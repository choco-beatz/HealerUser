import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healer_user/bloc/therapist/therapist_bloc.dart';
import 'package:healer_user/constants/colors.dart';
import 'package:healer_user/view/therapist/widgets/empty.dart';
import 'package:healer_user/view/therapist/widgets/therapist_card.dart';
import 'package:healer_user/view/therapist/widgets/therapist_card_ongoing.dart';
import 'package:healer_user/view/therapist/widgets/therapist_card_pending.dart';
import 'package:healer_user/view/therapist/widgets/therapist_detail.dart';

class ViewTherapist extends StatefulWidget {
  const ViewTherapist({super.key});

  @override
  State<ViewTherapist> createState() => _ViewTherapistState();
}

class _ViewTherapistState extends State<ViewTherapist>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        log('Tab changed to index: ${tabController.index}');
        if (mounted) {
          switch (tabController.index) {
            case 0:
              context.read<TherapistBloc>().add(FetchTherapistEvent());
              break;
            case 1:
              context
                  .read<TherapistBloc>()
                  .add(RequestStatusEvent(status: "Pending"));
              break;
            case 2:
              context
                  .read<TherapistBloc>()
                  .add(RequestStatusEvent(status: "Accepted"));
              break;
          }
        }
      }
    });
    context.read<TherapistBloc>().add(FetchTherapistEvent());
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Therapists',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            leading: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  Icons.chevron_left,
                  size: 30,
                )),
            backgroundColor: white,
            bottom: TabBar(
                controller: tabController,
                dividerColor: white,
                labelColor: white,
                unselectedLabelColor: main1,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: main1),
                tabs: const [
                  Tab(text: "      Available      "),
                  Tab(text: "       Pending       "),
                  Tab(text: "       On going       ")
                ]),
          ),
          body: TabBarView(
            controller: tabController,
            children: [
              BlocBuilder<TherapistBloc, TherapistState>(
                builder: (context, state) {
                  final therapists = state.list;
                  if (therapists.isEmpty) {
                    return const Center(
                      child: EmptyTherapist(
                        description: 'No one is here',
                      ),
                    );
                  }
                  return ListView.builder(
                      itemCount: therapists.length,
                      itemBuilder: (context, index) {
                        final therapist = therapists[index];
                        // log(therapist.toString());
                        return GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TherapistDetails(
                                        therapist: therapist))),
                            child: TherapistCard(
                              height: height,
                              width: width,
                              therapist: therapist,
                            ));
                      });
                },
              ),
              BlocBuilder<TherapistBloc, TherapistState>(
                builder: (context, state) {
                  final therapists = state.list;
                  if (therapists.isEmpty) {
                    return const Center(
                      child: EmptyTherapist(
                        description: 'No one is here',
                      ),
                    );
                  }
                  return ListView.builder(
                      itemCount: therapists.length,
                      itemBuilder: (context, index) {
                        final therapist = therapists[index];
                        log(therapist.toString());
                        return GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TherapistDetails(
                                        therapist: therapist))),
                            child: TherapistCardPending(
                              height: height,
                              width: width,
                              therapist: therapist,
                            ));
                      });
                },
              ),
              BlocBuilder<TherapistBloc, TherapistState>(
                builder: (context, state) {
                  final therapists = state.list;
                  if (therapists.isEmpty) {
                    return const Center(
                      child: EmptyTherapist(
                        description: "No one is here",
                      ),
                    );
                  }
                  return ListView.builder(
                      itemCount: therapists.length,
                      itemBuilder: (context, index) {
                        final therapist = therapists[index];
                        // log(therapist.toString());
                        return GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TherapistDetails(
                                        therapist: therapist))),
                            child: TherapistCardOngoing(
                              height: height,
                              width: width,
                              therapist: therapist,
                            ));
                      });
                },
              ),
            ],
          )),
    );
  }
}
