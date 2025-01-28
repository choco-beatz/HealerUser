part of 'appointment_bloc.dart';

abstract class AppointmentState {}


final class AppointmentInitial extends AppointmentState {}


final class AppointmentLoading extends AppointmentState {}


final class AppointmentError extends AppointmentState {
  final String errorMessage;

  AppointmentError(this.errorMessage);
}


final class SlotsLoaded extends AppointmentState {
  final List<SlotModel> slots;

  SlotsLoaded(this.slots);
}


final class AppointmentsLoaded extends AppointmentState {
  final List<AppointmentModel> appointments;

  AppointmentsLoaded(this.appointments);
}


final class SlotConfirmed extends AppointmentState {
  final bool isSuccess;

  SlotConfirmed(this.isSuccess);
}


final class PaymentInitiated extends AppointmentState {
  final PaymentResponseModel paymentResponse;

  PaymentInitiated(this.paymentResponse);
}

final class PaymentVerified extends AppointmentState {
  final bool isSuccess;

  PaymentVerified(this.isSuccess);
}