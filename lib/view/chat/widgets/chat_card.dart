import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:healer_user/constants/colors.dart';
import 'package:healer_user/constants/space.dart';
import 'package:healer_user/constants/textstyle.dart';
import 'package:healer_user/model/therapist_model/therapist_model.dart';
import 'package:healer_user/services/chat/socket.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({
    super.key,
    required this.therapist,
    required this.height,
    required this.width,
    required this.socketService,
  });

  final double height;
  final double width;
  final SocketService socketService;
  final TherapistModel therapist;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Card(
        color: white,
        child: SizedBox(
            height: height * 0.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                    backgroundColor: transparent,
                    radius: width * 0.07,
                    child: (therapist.image.split('.').last == 'png')
                        ? Image.network(
                            fit: BoxFit.fitHeight,
                            therapist.image,
                            width: 90,
                            height: 90,
                          )
                        : ClipOval(
                            child: Image.network(
                              fit: BoxFit.fitHeight,
                              therapist.image,
                              width: 90,
                              height: 90,
                            ),
                          )),
                SizedBox(
                  width: width * 0.68,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(therapist.profile.name, style: smallBold),
                      smallSpace,
                      const Text('Message.....', style: textFieldStyle),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
