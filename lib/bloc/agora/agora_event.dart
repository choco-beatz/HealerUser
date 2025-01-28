part of 'agora_bloc.dart';

abstract class AgoraEvent {}

class InitializeAgora extends AgoraEvent {
  final String appId;

  InitializeAgora(this.appId);
}


class ReceiveCall extends AgoraEvent {
  final String callerId;
  final String channel;

  ReceiveCall({
    required this.callerId,
    required this.channel,
  });
}

class JoinVideoCall extends AgoraEvent {
  final String token;
  final String callID;
  final int uid;
  final String callerId;

  JoinVideoCall({
    required this.token,
    required this.callID,
    required this.uid,
    required this.callerId,
  });
}


class LeaveCall extends AgoraEvent {}

class DisposeAgora extends AgoraEvent {}
