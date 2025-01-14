import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:healer_user/model/appointmentmodel/appointment_model.dart';
import 'package:healer_user/model/appointmentmodel/payment_response_model.dart';
import 'package:healer_user/model/appointmentmodel/slot_model.dart';
import 'package:healer_user/model/appointmentmodel/cofirmslot_model.dart';
import 'package:healer_user/services/appointment/appointment_service.dart';

part 'appointment_event.dart';
part 'appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  AppointmentBloc() : super(AppointmentInitial()) {
    on<GetSlotsEvent>((event, emit) async {
      if (state.isLoading) return;

      try {
        List<SlotModel> list = await fetchSlots(event.therapistId, event.date);
        log(list.toString());
        emit(state.copyWith(
          slots: list,
          isLoading: false,
          isInitialized: true,
        ));
      } catch (e) {
        log(e.toString());
        emit(state.copyWith(
          isLoading: false,
          // hasError: true,
        ));
      }
    });

    on<SlotStatusEvent>((event, emit) async {
      if (state.isLoading) return;

      try {
        List<AppointmentModel> list = await slotStatus(event.status);
        log(list.toString());
        emit(state.copyWith(
          appointments: list,
          isLoading: false,
          isInitialized: true,
        ));
      } catch (e) {
        log(e.toString());
        emit(state.copyWith(
          isLoading: false,
          hasError: true,
        ));
      }
    });

    on<ConfirmSlotsEvent>((event, emit) async {
      if (state.isLoading) return;

      try {
        bool success = await confirmSlots(event.therapistId, event.slot);
        log(success.toString());
        emit(state.copyWith(
          isSuccess: success,
          isLoading: false,
          isConfirm: true,
          isInitialized: true,
        ));
      } catch (e) {
        log(e.toString());
        emit(state.copyWith(
          isLoading: false,
          hasError: true,
        ));
      }
    });

    on<InitiatePaymentEvent>((event, emit) async {
      if (state.isLoading) return;

      try {
        PaymentResponseModel response =
            await initiatePayment(event.amount, event.appointmentId);

        emit(state.copyWith(
          isSuccess: true,
          paymentResponse: response,
          isLoading: false,
        ));
      } catch (e) {
        log(e.toString());
        emit(state.copyWith(
          isLoading: false,
          hasError: true,
        ));
      }
    });

    on<VerifyPaymentEvent>((event, emit) async {
      if (state.isLoading) return;

      try {
        bool success = await verifyPayment(
            event.paymentId, event.orderId, event.signature);
        log('success: $success');
        emit(state.copyWith(
          isSuccess: success,
          isLoading: false,
        ));
      } catch (e) {
        log('verify:${e.toString()}');
        emit(state.copyWith(
          isLoading: false,
          hasError: true,
        ));
      }
    });
  }
}
