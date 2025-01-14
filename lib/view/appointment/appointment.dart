import 'package:flutter/material.dart';

import 'package:healer_user/constants/colors.dart';
import 'package:healer_user/constants/textstyle.dart';
import 'package:healer_user/view/appointment/screens/appointment_calender.dart';
import 'package:healer_user/view/appointment/screens/appointment_status.dart';

class Appointment extends StatefulWidget {
  final String therapistId;
  const Appointment({
    super.key,
    required this.therapistId,
  });
  @override
  State<Appointment> createState() => _AppoinmentState();
}

class _AppoinmentState extends State<Appointment>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  final List<Key> calendarKeys = List.generate(
    4,
    (index) => GlobalKey(debugLabel: 'calendar_$index'),
  );

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(_handleTabChange);
  }

  void _handleTabChange() {
    if (!tabController.indexIsChanging) {
      if (mounted) {
        switch (tabController.index) {
          case 0:
            // context.read<TherapistBloc>().add(OnGoingClientEvent());
            break;
          case 1:
            // context
            //       .read<TherapistBloc>()
            //       .add(RequestStatusEvent(status: "Accepted"));
            break;
          case 2:
            // context.read<AppointmentBloc>().add(FetchSlotsEvent());
            break;
        }
      }
    }
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Appointments',
            style: smallBold,
          ),
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.chevron_left, size: 30),
          ),
          backgroundColor: white,
          bottom: TabBar(
            controller: tabController,
            dividerColor: white,
            labelColor: white,
            labelPadding: const EdgeInsets.symmetric(horizontal: 2),
            isScrollable: true,
            unselectedLabelColor: main1,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: main1),
            tabs: const [
              Tab(text: "        Slots       "),
              Tab(text: "      Pending     "),
              Tab(text: "      Confirm     "),
              Tab(text: "     Upcoming     "),
            ],
          ),
        ),
        body: TabBarView(controller: tabController, children: [
          AppointmentCalender(therapistId: widget.therapistId),
          const AppointmentStatus(status: 'pending'),
          const AppointmentStatus(status: 'accepted'),
          const AppointmentStatus(status: 'confirmed'),
        ]),
      ),
    );
  }
}
