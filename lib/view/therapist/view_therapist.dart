import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healer_user/bloc/therapist/therapist_bloc.dart';
import 'package:healer_user/constants/colors.dart';
import 'package:healer_user/view/therapist/screens/available_therapist.dart';
import 'package:healer_user/view/therapist/screens/request_status_page.dart';

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
              Future.microtask(() =>
                  context.read<TherapistBloc>().add(FetchTherapistEvent()));
              break;
            case 1:
              // Future.microtask(() => context
              //     .read<TherapistBloc>()
              //     .add(RequestStatusEvent(status: "Pending")));
              break;
            case 2:
              // Future.microtask(() => context
              //     .read<TherapistBloc>()
              //     .add(RequestStatusEvent(status: "Accepted")));
              break;
          }
        }
      }
    });
    Future.microtask(
        () => context.read<TherapistBloc>().add(FetchTherapistEvent()));
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Therapists',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.chevron_left, size: 30),
          ),
          backgroundColor: white,
          bottom: TabBar(
            controller: tabController,
            labelColor: white,
            unselectedLabelColor: main1,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: main1,
            ),
            tabs: const [
              Tab(text: "      Available      "),
              Tab(text: "       Pending       "),
              Tab(text: "       On going       "),
            ],
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: [
            const AvailableTherapistsPage(),
            BlocProvider(
              create: (context) =>
                  TherapistBloc()..add(RequestStatusEvent(status: "Pending")),
              child: const RequestStatusPage(
                status: "Pending",
              ),
            ),
            BlocProvider(
              create: (context) =>
                  TherapistBloc()..add(RequestStatusEvent(status: "Accepted")),
              child: const RequestStatusPage(
                status: "Accepted",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
