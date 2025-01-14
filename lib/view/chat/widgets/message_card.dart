

import 'package:flutter/material.dart';
import 'package:healer_user/constants/colors.dart';
import 'package:healer_user/constants/space.dart';
import 'package:healer_user/constants/textstyle.dart';
import 'package:healer_user/services/chat/socket.dart';

class MessageCard extends StatelessWidget {
  const MessageCard({
    super.key,
    required this.height,
    required this.width,
    required this.socketService,
    required this.image,
    required this.lastMessage,
    required this.name,
  });

  final String image;
  final String lastMessage;
  final String name;
  final double height;
  final double width;
  final SocketService socketService;

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
                    child: (image.split('.').last == 'png')
                        ? Image.network(
                            fit: BoxFit.fitHeight,
                            image,
                            width: 90,
                            height: 90,
                          )
                        : ClipOval(
                            child: Image.network(
                              fit: BoxFit.fitHeight,
                              image,
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
                      Text(name, style: smallBold),
                      smallSpace,
                      Text(lastMessage, style: textFieldStyle),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
