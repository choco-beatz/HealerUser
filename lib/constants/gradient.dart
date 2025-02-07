import 'package:flutter/material.dart';
import 'colors.dart';


const gradient = LinearGradient(
  colors: [main2, main1],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const redGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      red,
      red1,
    ]);

const nullGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [white, white]);
