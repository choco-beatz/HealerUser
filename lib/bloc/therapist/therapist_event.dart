// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'therapist_bloc.dart';

class TherapistEvent {}

class FetchTherapistEvent extends TherapistEvent {}

class RequestSentEvent extends TherapistEvent {
  
  String therapistId;
  RequestSentEvent({
    required this.therapistId,
  });
}

class RequestStatusEvent extends TherapistEvent {
  
  String status;
  RequestStatusEvent({
    required this.status,
  });
}
