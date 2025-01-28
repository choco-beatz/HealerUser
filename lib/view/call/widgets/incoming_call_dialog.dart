import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:healer_user/constants/textstyle.dart';
import 'package:healer_user/services/chat/socket.dart';
import 'package:healer_user/view/call/screens/video_call_page.dart';
import 'package:healer_user/view/widgets/dialog_button.dart';


void showIncomingCallDialog(
    BuildContext context, dynamic data, SocketService socketService, String userId) {
  // Log the received data for debugging
  log('Incoming call data: $data');

  // Safely extract caller info from the nested structure
  final fromUserId = data['from']?['userId'];
  final fromName = data['from']?['name'];
  
  if (fromUserId == null) {
    log('Invalid call data received: $data');
    return;
  }

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) => AlertDialog(  // Use dialogContext instead
      title: const Text("Incoming Call", style: semiBold,),
      content: Text("Appointment with: ${fromName ?? 'Unknown'}", style: bigBold,),
      actions: [
        GestureDetector(
          onTap: () {
            // Accept call logic
            socketService.emitEvent('accept-call', {
              'from': fromUserId,
              'to': userId  // Add this variable from your class
            });

            Navigator.pushReplacement(
              dialogContext,  // Use dialogContext
              MaterialPageRoute(
                builder: (context) => const VideoCallPage(),
              ),
            );
          },
          child: buildButton(text: 'Accept'),
        ),
        GestureDetector(
          onTap: () {
            // Decline call logic
            socketService.emitEvent('end-call', {
              'from': userId,  // Add this variable from your class
              'to': fromUserId
            });
            Navigator.pop(dialogContext);  // Use dialogContext
          },
          child:  buildButton(text:"Decline", imp: true),
        ),
      ],
    ),
  );
}