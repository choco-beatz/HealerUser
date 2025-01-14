part of 'appointment_bloc.dart';

class AppointmentEvent {}

class GetSlotsEvent extends AppointmentEvent {
  final String therapistId;
  final String date;

  GetSlotsEvent({required this.therapistId, required this.date});
}

class ConfirmSlotsEvent extends AppointmentEvent {
  final String therapistId;
  final ConfirmSlotModel slot;

  ConfirmSlotsEvent({required this.therapistId, required this.slot});
}

class SlotStatusEvent extends AppointmentEvent {
  final String status;

  SlotStatusEvent({required this.status});
}

class InitiatePaymentEvent extends AppointmentEvent {
  final String appointmentId;
  final String amount;

  InitiatePaymentEvent({required this.appointmentId, required this.amount});
}

class VerifyPaymentEvent extends AppointmentEvent {
  final String paymentId;
  final String orderId;
  final String signature;

  VerifyPaymentEvent({required this.paymentId, required this.orderId, required this.signature});
}
