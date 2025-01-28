import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healer_user/bloc/appointment/appointment_bloc.dart';
import 'package:healer_user/constants/snackbar.dart';
import 'package:healer_user/constants/space.dart';
import 'package:healer_user/constants/textstyle.dart';
import 'package:healer_user/view/appointment/widgets/confirm_slot.dart';
import 'package:healer_user/view/widgets/loading.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:healer_user/constants/colors.dart';
import 'package:healer_user/constants/gradient.dart';

class AppointmentCalender extends StatefulWidget {
  final String therapistId;
  const AppointmentCalender({
    super.key,
    required this.therapistId,
  });

  @override
  State<AppointmentCalender> createState() => _AppointmentCalenderState();
}

class _AppointmentCalenderState extends State<AppointmentCalender> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  String get formatedDate => DateFormat('yyyy-MM-dd').format(_selectedDay!);

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<AppointmentBloc, AppointmentState>(
      listener: (context, state) {
        if (state is SlotConfirmed) {
          ScaffoldMessenger.of(context).showSnackBar(slotConfirmed);
        } else if (state is AppointmentError) {
          ScaffoldMessenger.of(context).showSnackBar(somethingWentWrong);
        }
      },
      child: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                color: main2trans,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: TableCalendar(
                  enabledDayPredicate: (date) {
                    return date.isAfter(
                        DateTime.now().subtract(const Duration(days: 1)));
                  },
                  headerStyle: const HeaderStyle(
                    headerPadding: EdgeInsets.zero,
                    titleTextStyle: TextStyle(
                        color: white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    decoration: BoxDecoration(
                        gradient: gradient,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10))),
                    formatButtonVisible: false,
                    leftChevronIcon: Icon(
                      Icons.chevron_left,
                      color: white,
                      size: 28,
                    ),
                    rightChevronIcon: Icon(
                      Icons.chevron_right,
                      color: white,
                      size: 28,
                    ),
                  ),
                  calendarStyle: const CalendarStyle(
                    outsideTextStyle: TextStyle(color: textColor, fontSize: 16),
                    disabledTextStyle:
                        TextStyle(color: textColor, fontSize: 16),
                    weekendTextStyle: TextStyle(color: black, fontSize: 16),
                    defaultTextStyle: TextStyle(color: black, fontSize: 16),
                    todayDecoration: BoxDecoration(
                      gradient: gradient,
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: BoxDecoration(
                      gradient: gradient,
                      shape: BoxShape.circle,
                    ),
                  ),
                  daysOfWeekStyle: const DaysOfWeekStyle(
                    weekendStyle: TextStyle(color: black, fontSize: 14),
                    weekdayStyle: TextStyle(color: black, fontSize: 14),
                  ),
                  focusedDay: DateTime.now(),
                  firstDay: DateTime(2002),
                  lastDay: DateTime(2050),
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                    final formattedDate =
                        DateFormat('yyyy-MM-dd').format(selectedDay);
                    context.read<AppointmentBloc>().add(
                          GetSlotsEvent(
                            therapistId: widget.therapistId,
                            date: formattedDate,
                          ),
                        );
                  },
                  calendarFormat: CalendarFormat.month,
                ),
              ),
              space,
              const Text(
                'Available Time Slots',
                style: smallBold,
              ),
              BlocBuilder<AppointmentBloc, AppointmentState>(
                  builder: (context, state) {
                if (state is AppointmentLoading) {
                  return const Loading();
                } else if (state is AppointmentError) {
                  return const Center(
                    child: Text('Error loading slots'),
                  );
                } else if (state is SlotsLoaded) {
                  final slots = state.slots;
                  if (slots.isEmpty) {
                    return const Center(
                      child: Text('No slots available'),
                    );
                  }

                  return Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    alignment: WrapAlignment.start,
                    children: slots.map((slot) {
                      final times = '${slot.startTime} - ${slot.endTime}';
                      return InkWell(
                          onTap: () {
                            showConfirmSlotDialog(formatedDate, context, slot,
                                times, widget.therapistId);
                          },
                          child: Chip(
                            side: BorderSide.none,
                            backgroundColor: main1trans,
                            label: Text(times, style: colorTextStyle),
                          ));
                    }).toList(),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              }),
            ]),
      )),
    ));
  }
}
