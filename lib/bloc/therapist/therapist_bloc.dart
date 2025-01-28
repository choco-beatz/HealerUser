import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:healer_user/model/therapist_model/therapist_model.dart';
import 'package:healer_user/services/therapist/therapist_service.dart';
import 'package:healer_user/services/user/user_id.dart';

part 'therapist_event.dart';
part 'therapist_state.dart';

class TherapistBloc extends Bloc<TherapistEvent, TherapistState> {
  TherapistBloc() : super(TherapistInitial()) {
    on<FetchTherapistEvent>((event, emit) async {
      emit(TherapistLoading());
      try {
        final therapists = await fetchTherapist();
        emit(TherapistLoaded(list: therapists));
      } catch (e) {
        emit(TherapistError(message: e.toString()));
      }
    });

    on<RequestStatusEvent>((event, emit) async {
      emit(TherapistLoading());
      try {
        final therapists = await requestStatus(event.status);
        emit(RequestStatusLoaded(list: therapists));
      } catch (e) {
        emit(TherapistError(message: e.toString()));
      }
    });

    on<RequestSentEvent>((event, emit) async {
      emit(TherapistLoading());
      try {
        final userId = await getUserId();
        log(userId ?? 'User ID is null');
        log(event.therapistId);

        int code = await requestSent(userId!, event.therapistId);

        if (code == 200 || code == 201) {
          emit(RequestSentState(
            isSuccess: true,
            message: 'Request sent successfully',
            requestCode: code,
          ));
        } else {
          emit(RequestSentState(
            isSuccess: false,
            message: 'Failed to send request',
            requestCode: code,
          ));
        }
      } catch (e) {
        emit(TherapistError(message: e.toString()));
      }
    });
  }
}
