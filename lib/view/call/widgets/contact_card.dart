import 'package:flutter/material.dart';
import 'package:healer_user/constants/colors.dart';
import 'package:healer_user/constants/textstyle.dart';
import 'package:healer_user/model/therapist_model/therapist_model.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({
    super.key,
    required this.therapist,
    required this.height,
    required this.width,
    required this.onCall,
    required this.onVideoCall, required this.onDetails,
  });

  final double height;
  final double width;
  final VoidCallback onDetails;
  final TherapistModel therapist;
  final VoidCallback onCall;
  final VoidCallback onVideoCall;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      child: ListTile(
        onTap: onDetails,
        leading: CircleAvatar(
          backgroundImage: NetworkImage(therapist.image!),
        ),
        title: Text(therapist.name),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.call, color: main1),
              onPressed: onCall,
            ),
            IconButton(
              icon: const Icon(Icons.video_call, color: main1),
              onPressed: onVideoCall,
            ),
          ],
        ),
      ),
    );
  }
}
