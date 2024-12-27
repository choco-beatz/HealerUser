import 'package:flutter/material.dart';
import 'package:healer_user/constants/textstyle.dart';

//login failed
const loginErrorSnackBar = SnackBar(
    content: Row(
  children: [
    Image(height: 50, width: 50, image: AssetImage('asset/failed.png')),
    Text(
      '  Login Failed!!',
      style: buttonText,
    )
  ],
));

//something went wrong
const somethingWentWrong = SnackBar(
    content: Row(
  children: [
    Image(height: 50, width: 50, image: AssetImage('asset/failed.png')),
    Text(
      '  Something went wrong!',
      style: buttonText,
    )
  ],
));

//therapist created
const therapistCreated = SnackBar(
    content: Row(
  children: [
    Image(height: 50, width: 50, image: AssetImage('asset/happy.png')),
    Text(
      '  Therapist added successfully!!',
      style: buttonText,
    )
  ],
));

//slot confirmed
const slotConfirmed = SnackBar(
    content: Row(
  children: [
    Image(height: 50, width: 50, image: AssetImage('asset/happy.png')),
    Text(
      '  Slot Confirmed!!',
      style: buttonText,
    )
  ],
));

//therapist created
const otpResent = SnackBar(
    content: Row(
  children: [
    Image(height: 50, width: 50, image: AssetImage('asset/happy.png')),
    Text(
      '  New OTP sent to your mail!!',
      style: buttonText,
    )
  ],
));

//therapist created
const therapistEdited = SnackBar(
    content: Row(
  children: [
    Image(height: 50, width: 50, image: AssetImage('asset/happy.png')),
    Text(
      '  Details edited successfully!!',
      style: buttonText,
    )
  ],
));

//password doesnt match
const misMatch = SnackBar(
    content: Row(
  children: [
    Image(height: 50, width: 50, image: AssetImage('asset/failed.png')),
    Text(
      "  Password Doesn't match!",
      style: buttonText,
    )
  ],
));

//password doesnt match
const requestSent = SnackBar(
    content: Row(
  children: [
    Image(height: 50, width: 50, image: AssetImage('asset/happy.png')),
    Text(
      "  Request sent!",
      style: buttonText,
    )
  ],
));
