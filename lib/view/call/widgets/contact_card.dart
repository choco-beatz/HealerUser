import 'package:flutter/material.dart';
import 'package:healer_user/constants/colors.dart';
import 'package:healer_user/constants/textstyle.dart';
import 'package:healer_user/model/therapistmodel/therapist_model.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({
    super.key,
    required this.therapist,
    required this.height,
    required this.width,
    required this.onCall,
    required this.onVideoCall,
  });

  final double height;
  final double width;
  final TherapistModel therapist;
  final VoidCallback onCall;
  final VoidCallback onVideoCall;

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
                child: (therapist.image!.split('.').last == 'png')
                    ? Image.network(
                        fit: BoxFit.fitHeight,
                        therapist.image!,
                        width: 90,
                        height: 90,
                      )
                    : ClipOval(
                        child: Image.network(
                          fit: BoxFit.fitHeight,
                          therapist.image!,
                          width: 90,
                          height: 90,
                        ),
                      ),
              ),
              Text(therapist.name, style: smallBold),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: onCall,
                    icon: const Icon(
                      Icons.call,
                      color: main1,
                      size: 30,
                    ),
                  ),
                  IconButton(
                    onPressed: onVideoCall,
                    icon: const Icon(
                      Icons.videocam,
                      color: main1,
                      size: 30,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
