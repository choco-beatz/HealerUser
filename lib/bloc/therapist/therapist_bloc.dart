import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:healer_user/model/therapistmodel/therapist_model.dart';
import 'package:healer_user/services/therapist/therapist_service.dart';
import 'package:healer_user/services/user/user_id.dart';

part 'therapist_event.dart';
part 'therapist_state.dart';

class TherapistBloc extends Bloc<TherapistEvent, TherapistState> {
  TherapistBloc() : super(TherapistInitial()) {
    on<FetchTherapistEvent>((event, emit) async {
      if (state.isLoading) return;

      try {
        final therapists = await fetchTherapist();
        emit(state.copyWith(
          list: therapists,
          isLoading: false,
          isInitialized: true,
        ));
      } catch (e) {
        log(e.toString());
        emit(state.copyWith(
          isLoading: false,
          hasError: true,
          message: e.toString(),
        ));
      }
    });

    on<RequestStatusEvent>((event, emit) async {
      if (state.isLoading) return;

      try {
        final therapists = await requestStatus(event.status);
        emit(state.copyWith(
          list: therapists,
          isLoading: false,
          isInitialized: true,
        ));
      } catch (e) {
        log(e.toString());
        emit(state.copyWith(
          isLoading: false,
          hasError: true,
          message: e.toString(),
        ));
      }
    });

// @override
// Stream<TherapistState> mapEventToState(TherapistEvent event) async* {
//   if (event is FetchTherapistEvent) {
//     yield TherapistState(list: await fetchTherapist());
//   } else if (event is RequestStatusEvent) {
//     if (event.status == "Pending") {
//       yield TherapistState(pendingList: await requestStatus("Pending"));
//     } else if (event.status == "Accepted") {
//       yield TherapistState(ongoingList: await requestStatus("Accepted"));
//     }
//   }
// }

 on<RequestSentEvent>((event, emit) async {
  try {
    emit(state.copyWith(isLoading: true));

    final userId = await getUserId();
    log(userId ?? 'User ID is null');
    log(event.therapistId);

    int code = await requestSent(userId!, event.therapistId);

    if (code == 200 || code == 201) {
      final updatedTherapists = Set<String>.from(state.requestedTherapists)
        ..add(event.therapistId);

      final updatedStatuses = {
        ...state.requestStatuses,
        event.therapistId: "Pending",
      };

      emit(state.copyWith(
        isLoading: false,
        isSuccess: true,
        requestCode: code,
        requestedTherapists: updatedTherapists,
        requestStatuses: updatedStatuses,
        message: 'Request sent',
      ));
    } else if (code == 422) {
      emit(state.copyWith(
        requestCode: 422,
        isLoading: false,
        hasError: true,
        requestStatuses: {
          ...state.requestStatuses,
          event.therapistId: "Failed",
        },
        message: 'Failed to send request',
      ));
    }
  } catch (e) {
    emit(state.copyWith(
      isLoading: false,
      hasError: true,
      requestStatuses: {
        ...state.requestStatuses,
        event.therapistId: "Error",
      },
      message: e.toString(),
    ));
  }
});

  }
}
