import 'package:flutter/material.dart';
import 'package:healer_user/constants/textstyle.dart';

class EmptySlot extends StatelessWidget {
  const EmptySlot({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Center(
        child: Column(
          children: [
            Image.asset(
              'asset/emptySlot.jpg',
              height: 175,
            ),
            const Text(
              'No Slots Available',
              style: smallBold,
            )
          ],
        ),
      ),
    );
  }
}
