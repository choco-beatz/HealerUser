part of 'therapist_bloc.dart';

abstract class TherapistState {}

class TherapistInitial extends TherapistState {}

class TherapistLoading extends TherapistState {}

class TherapistLoaded extends TherapistState {
  final List<TherapistModel> list;
  final Map<String, String> requestStatuses;
  final Set<String> requestedTherapists;

  TherapistLoaded({
    required this.list,
    this.requestStatuses = const {},
    this.requestedTherapists = const {},
  });
}

class TherapistError extends TherapistState {
  final String message;

  TherapistError({required this.message});
}

class RequestStatusLoaded extends TherapistState {
  final List<TherapistModel> list;

  RequestStatusLoaded({required this.list});
}

class RequestSentState extends TherapistState {
  final bool isSuccess;
  final String message;
  final int requestCode;

  RequestSentState({
    required this.isSuccess,
    required this.message,
    required this.requestCode,
  });
}