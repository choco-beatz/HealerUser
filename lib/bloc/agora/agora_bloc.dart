import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:healer_user/services/agora/agora_service.dart';
import 'package:healer_user/services/agora/constants.dart';

part 'agora_event.dart';
part 'agora_state.dart';

class AgoraBloc extends Bloc<AgoraEvent, AgoraState> {
  final AgoraService _agoraService = AgoraService();

  AgoraBloc() : super(AgoraInitial()) {
    on<InitializeAgora>(_onInitializeAgora);
  
    on<JoinVideoCall>(_onJoinVideoCall);
    on<ReceiveCall>(_onReceiveCall);

   on<LeaveCall>(_onLeaveCall);
   on<DisposeAgora>(_onDisposeAgora);
  }

  // Event handlers
Future<void> _onInitializeAgora(
  InitializeAgora event,
  Emitter<AgoraState> emit,
) async {
  try {
    await _agoraService.initializeAgora(appId);
    emit(AgoraLoadedState(
      agoraService: _agoraService,
      isInitialized: true,
    ));
  } catch (error, stackTrace) {
    emit(AgoraError('Initialization failed: ${error.toString()}'));
    log('Agora Initialization Error: $error');
    log('StackTrace: $stackTrace');
  }
}


 

Future<void> _onJoinVideoCall(
  JoinVideoCall event,
  Emitter<AgoraState> emit,
) async {
  try {
    await _agoraService.joinVideoCall(
      callID: event.callID,
      uid: uid,
      token: token,
      onLocalUserJoined: () {
        if (!emit.isDone) emit(VideoCallJoined(event.callID));
      },
      onUserJoined: (remoteUid) {
        if (!emit.isDone) emit(RemoteUserJoinedState(remoteUid));
      },
      onUserOffline: (remoteUid) {
        if (!emit.isDone) emit(RemoteUserLeftState(remoteUid));
      },
    );
  } catch (error) {
    if (!emit.isDone) emit(AgoraError(error.toString()));
  }
}



  Future<void> _onReceiveCall(
    ReceiveCall event,
    Emitter<AgoraState> emit,
  ) async {
    emit(CallIncomingState(
      callerId: event.callerId,
      channel: channel,
    ));
  }

  

Future<void> _onLeaveCall(
  LeaveCall event,
  Emitter<AgoraState> emit,
) async {
  try {
    await _agoraService.leaveCall();
    if (!emit.isDone) emit(AgoraInitial());
  } catch (error) {
    if (!emit.isDone) emit(AgoraError(error.toString()));
  }
}

Future<void> _onDisposeAgora(
  DisposeAgora event,
  Emitter<AgoraState> emit,
) async {
  try {
    await _agoraService.dispose();
    if (!emit.isDone) emit(AgoraInitial());
  } catch (error) {
    if (!emit.isDone) emit(AgoraError('Dispose failed: ${error.toString()}'));
  }
}



  @override
  Future<void> close() {
    _agoraService.dispose();
    return super.close();
  }
}