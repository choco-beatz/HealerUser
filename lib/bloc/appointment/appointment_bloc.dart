import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:healer_user/model/appointment_model/appointment_model.dart';
import 'package:healer_user/model/appointment_model/payment_response_model.dart';
import 'package:healer_user/model/appointment_model/slot_model.dart';
import 'package:healer_user/model/appointment_model/cofirmslot_model.dart';
import 'package:healer_user/services/appointment/appointment_service.dart';

part 'appointment_event.dart';
part 'appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  AppointmentBloc() : super(AppointmentInitial()) {
    on<GetSlotsEvent>((event, emit) async {
      emit(AppointmentLoading());

      try {
        List<SlotModel> list = await fetchSlots(event.therapistId, event.date);
        emit(SlotsLoaded(list));
      } catch (e) {
        log(e.toString());
        emit(AppointmentError('Failed to fetch slots.'));
      }
    });

    on<SlotStatusEvent>((event, emit) async {
      emit(AppointmentLoading());

      try {
        List<AppointmentModel> list = await slotStatus(event.status);
        emit(AppointmentsLoaded(list));
      } catch (e) {
        log(e.toString());
        emit(AppointmentError('Failed to fetch appointments.'));
      }
    });

    on<ConfirmSlotsEvent>((event, emit) async {
      emit(AppointmentLoading());

      try {
        bool success = await confirmSlots(event.therapistId, event.slot);
        emit(SlotConfirmed(success));
      } catch (e) {
        log(e.toString());
        emit(AppointmentError('Failed to confirm slots.'));
      }
    });

    on<InitiatePaymentEvent>((event, emit) async {
      emit(AppointmentLoading());

      try {
        PaymentResponseModel response =
            await initiatePayment(event.amount, event.appointmentId);
        emit(PaymentInitiated(response));
      } catch (e) {
        log(e.toString());
        emit(AppointmentError('Failed to initiate payment.'));
      }
    });

    on<VerifyPaymentEvent>((event, emit) async {
      emit(AppointmentLoading());

      try {
        bool success = await verifyPayment(
            event.paymentId, event.orderId, event.signature);
        emit(PaymentVerified(success));
      } catch (e) {
        log(e.toString());
        emit(AppointmentError('Payment verification failed.'));
      }
    });
  }
}