part of 'appointment_bloc.dart';

@immutable
class AppointmentState {
  final bool isLoading;
  final bool isInitialized;
  final bool isSuccess;
  final bool isConfirm;
  final bool hasError;
  final List<SlotModel> slots;
  final List<AppointmentModel> appointments;
  const AppointmentState({
    this.slots = const [],
    this.isSuccess = false,
    this.isConfirm = false,
    this.appointments = const [],
    this.isLoading = false,
    this.isInitialized = false,
    this.hasError = false,
  });

  AppointmentState copyWith({
    List<SlotModel>? slots,
    bool? isLoading,
    bool? isConfirm,
    List<AppointmentModel>? appointments,
    bool? isInitialized,
    bool? isSuccess,
    bool? hasError,
  }) {
    return AppointmentState(
      slots: slots ?? this.slots,
      isConfirm: isConfirm ?? this.isConfirm,
      isLoading: isLoading ?? this.isLoading,
      appointments: appointments ?? this.appointments,
      isInitialized: isInitialized ?? this.isInitialized,
      isSuccess: isSuccess ?? this.isSuccess,
      hasError: hasError ?? this.hasError,
    );
  }
}

final class AppointmentInitial extends AppointmentState {}
