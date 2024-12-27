part of 'therapist_bloc.dart';

class TherapistState {
  final List<TherapistModel> list;
  final Map<String, String> requestStatuses;
  final List<TherapistModel> pendingList;
  final List<TherapistModel> ongoingList;
  final bool isLoading;
  final bool isInitialized;
  final bool isSuccess;
  final bool hasError;
  final int requestCode;
  final Set<String> requestedTherapists;
  final String requestStatus;
  final String message;

  TherapistState({
    this.list = const [],
    this.isLoading = false,
    this.isInitialized = false,
    this.requestStatuses = const {},
      this.pendingList = const [],
    this.ongoingList = const [],
    this.requestCode = 0,
    this.isSuccess = false,
    this.hasError = false,
    this.requestedTherapists = const {},
    this.requestStatus = '',
    this.message = '',
  });

  TherapistState copyWith({
    List<TherapistModel>? list,
    bool? isLoading,
    bool? isInitialized,
    bool? isSuccess,
    int? requestCode,
    Map<String, String>? requestStatuses,
    bool? hasError,
    Set<String>? requestedTherapists,
    String? requestStatus,
    String? message,
  }) {
    return TherapistState(
      requestCode: requestCode ?? this.requestCode,
      list: list ?? this.list,
      requestStatuses: requestStatuses ?? this.requestStatuses,
      isLoading: isLoading ?? this.isLoading,
      isInitialized: isInitialized ?? this.isInitialized,
      isSuccess: isSuccess ?? this.isSuccess,
      hasError: hasError ?? this.hasError,
      requestedTherapists: requestedTherapists ?? this.requestedTherapists,
      requestStatus: requestStatus ?? this.requestStatus,
      message: message ?? this.message,
    );
  }
}


final class TherapistInitial extends TherapistState {}
