import 'package:flutter/material.dart';
import 'package:healer_user/constants/textstyle.dart';
import 'package:healer_user/view/widgets/button.dart';
import 'package:lottie/lottie.dart';

void showLottieDialog(BuildContext context, String title, String message,
    {String? lottieAsset}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (lottieAsset != null)
              Lottie.asset(lottieAsset, height: 100, width: 100, repeat: false),
            const SizedBox(height: 10),
            Text(title, style: smallBold),
          ],
        ),
        content: Text(
          message,
          textAlign: TextAlign.start,
          style: textFieldStyle,
        ),
        actions: [
          InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: Button(text: 'OK'))
        ],
      );
    },
  );
}
