part of 'agora_bloc.dart';

abstract class AgoraState {}

class AgoraInitial extends AgoraState {}

class AgoraInitialized extends AgoraState {}

class AgoraLoggedIn extends AgoraState {}

class CallInvitationReceived extends AgoraState {
  final String channel;

  CallInvitationReceived(this.channel);
}

class VideoCallJoined extends AgoraState {
  final String channel;

  VideoCallJoined(this.channel);
}

class AgoraLoadedState extends AgoraState {
  final AgoraService agoraService;
  final bool isInitialized;

  AgoraLoadedState({
    required this.agoraService,
    required this.isInitialized,
  });
}

class VideoCallJoinedState extends AgoraState {}

class RemoteUserJoinedState extends AgoraState {
  final int remoteUid;

  RemoteUserJoinedState(this.remoteUid);
}

class RemoteUserLeftState extends AgoraState {
  final int remoteUid;

  RemoteUserLeftState(this.remoteUid);
}

class CallIncomingState extends AgoraState {
  final String callerId;
  final String channel;

  CallIncomingState({
    required this.callerId,
    required this.channel,
  });
}

class AgoraError extends AgoraState {
  final String error;

  AgoraError(this.error);
}
