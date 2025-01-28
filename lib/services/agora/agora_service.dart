import 'dart:developer';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:healer_user/services/agora/constants.dart';
import 'package:permission_handler/permission_handler.dart';

class AgoraService {
  late RtcEngine engine;
  bool localUserJoined = false;
  int? remoteUid;

  Future<void> initializeAgora(String appId) async {
    try {
      // Ensure permissions are granted before initialization
      await [Permission.microphone, Permission.camera].request();
      if (!await _checkPermissions()) {
        throw 'Permissions not granted';
      }

      // Verbose error handling
      engine = createAgoraRtcEngine();
      await engine.initialize(
        RtcEngineContext(
          appId: appId,
          // Add logging or error callback
          logConfig: const LogConfig(
            level: LogLevel.logLevelError,
          ),
        ),
      );
    } catch (e) {
      log('Agora Initialization Error: $e');
      // Provide more detailed error handling
      throw 'Agora initialization failed. Check app ID, permissions, and network.';
    }
  }

  Future<bool> _checkPermissions() async {
    final micStatus = await Permission.microphone.status;
    final cameraStatus = await Permission.camera.status;

    if (!micStatus.isGranted || !cameraStatus.isGranted) {
      final results =
          await [Permission.microphone, Permission.camera].request();

      return results.values.every((status) => status.isGranted);
    }
    return true;
  }

  Future<void> joinVideoCall({
    required String callID,
    required int uid,
    required String token,
    required Function onLocalUserJoined,
    required Function(int) onUserJoined,
    required Function(int) onUserOffline,
  }) async {
    await engine.joinChannel(
      token: token,
      channelId: channel,
      uid: uid,
      options: const ChannelMediaOptions(),
    );

    engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          log("Local user ${connection.localUid} joined");
          onLocalUserJoined();
        },
        onUserJoined:
            (RtcConnection connection, int newRemoteUid, int elapsed) {
          log("Remote user $remoteUid joined");
          onUserJoined(newRemoteUid);
        },
        onUserOffline: (RtcConnection connection, int offlineRemoteUid,
            UserOfflineReasonType reason) {
          log("Remote user $offlineRemoteUid left channel");
          onUserOffline(offlineRemoteUid);
        },
      ),
    );
  }

  Future<void> joinAudioCall(String callID, int userID, String token) async {
    await engine.enableAudio();
    await engine.startPreview();
    await engine.joinChannel(
      token: token,
      channelId: channel,
      uid: userID,
      options: const ChannelMediaOptions(),
    );

    log("Joined audio call with Call ID: $callID and User ID: $userID");
  }

  Future<void> leaveCall() async {
    await engine.leaveChannel();
    log("Left the call.");
  }

  Future<void> dispose() async {
    await engine.leaveChannel();
    await engine.release();
  }
}
