import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healer_user/bloc/appointment/appointment_bloc.dart';
import 'package:healer_user/constants/space.dart';
import 'package:healer_user/constants/textstyle.dart';
import 'package:healer_user/model/appointment_model/slot_model.dart';
import 'package:healer_user/model/appointment_model/cofirmslot_model.dart';
import 'package:healer_user/view/appointment/widgets/field.dart';
import 'package:healer_user/view/widgets/dialog_button.dart';

void showConfirmSlotDialog(String day, BuildContext context, SlotModel slot,
    String times, String therapistId) {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            title: const Text(
              "Confirm slot",
              style: smallBold,
              textAlign: TextAlign.center,
            ),
            content: SizedBox(
                width: 700,
                child: Form(
                    key: formkey,
                    child: SingleChildScrollView(
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          buildField(
                            initialValue: day,
                            label: "Date",
                          ),
                          space,
                          buildField(label: "Time", initialValue: times),
                          space,
                          buildField(
                              label: "Amount",
                              initialValue: slot.amount.toString()),
                          space,
                          Row(
                            children: [
                              InkWell(
                                  onTap: () {
                                    final confirmSlot = ConfirmSlotModel(
                                        startTime: slot.startTime,
                                        endTime: slot.endTime,
                                        amount: slot.amount,
                                        date: day);
                                    context.read<AppointmentBloc>().add(
                                        ConfirmSlotsEvent(
                                            therapistId: therapistId,
                                            slot: confirmSlot));
                                    Navigator.of(context).pop();
                                  },
                                  child: buildButton(text: 'Confirm')),
                              hSpace,
                              InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: buildButton(text: 'Cancel')),
                            ],
                          )
                        ])))));
      });
}
