import 'package:flutter/material.dart';
import 'package:healer_user/constants/colors.dart';
import 'package:healer_user/constants/textstyle.dart';
import 'package:healer_user/services/chat/socket.dart';
import 'package:healer_user/view/call/screens/video_call_page.dart';

class IncomingCallScreen extends StatelessWidget {
  final String callerId;
  final String callerName;
  final String callerImage;
  final SocketService socketService;
  final String userId;

  const IncomingCallScreen({
    super.key,
    required this.callerId,
    required this.callerName,
    required this.socketService,
    required this.userId, required this.callerImage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: main1trans,
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Profile Picture & Name
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               CircleAvatar(
                radius: 60,
                child: (callerImage.split('.').last == 'png')
                            ? Image.network(
                                fit: BoxFit.fitHeight,
                                callerImage,
                                width: 110,
                                height: 110,
                              )
                            : ClipOval(
                                child: Image.network(
                                  fit: BoxFit.fitHeight,
                                  callerImage,
                                  width: 110,
                                  height: 110,
                                ),
                              )),
              const SizedBox(height: 20),
              Text(
                callerName,
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: white),
              ),
              const SizedBox(height: 10),
              const Text(
                "Incoming Call...",
                style: textFieldStyle,
              ),
            ],
          ),

          // Accept & Decline Buttons
          Positioned(
            bottom: 80,
            left: 40,
            right: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    socketService.emitEvent('accept-call', {
                      'from': callerId,
                      'to': userId,
                    });

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const VideoCallPage(),
                      ),
                    );
                  },
                  child: const CircleAvatar(
                    radius: 35,
                    backgroundColor: green,
                    child: Icon(Icons.call, color: white, size: 30),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    socketService.emitEvent('end-call', {
                      'from': userId,
                      'to': callerId,
                    });

                    Navigator.pop(context);
                  },
                  child: const CircleAvatar(
                    radius: 35,
                    backgroundColor: red,
                    child: Icon(Icons.call_end, color: white, size: 30),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
