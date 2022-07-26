import 'package:flutter/material.dart';

const Color kActiveCardColor = Color(0xFF1D1E33);
const Color kInactiveCardColor = Color(0xFF111328);
const Color kBottomBarColor = Color(0x79EB1555);
const Color kMarsIconColor = Color(0xFF0014B4);
const double kBottomBarHeight = 40.0;

const kMainLabelTextStyle = TextStyle(
    letterSpacing: 1.5,
    shadows: [
      Shadow(
        offset: Offset(1.0, 1.0),
        // blurRadius: 15.0,
        color: Color(0xFF121213),
      )
    ],
    color: Color(0xA0F6F7FF),
    fontSize: 20.0,
    fontWeight: FontWeight.bold);

const kNumberTextStyle = TextStyle(
  fontSize: 35,
  fontWeight: FontWeight.w900,
);

const kNormalResultTextStyle = TextStyle(
    color: Color(0xFF24D876), fontSize: 28.0, fontWeight: FontWeight.bold);

const kOverweightResultTextStyle = TextStyle(
    color: Color(0xFFBE662C), fontSize: 28.0, fontWeight: FontWeight.bold);

const kUnderweightResultTextStyle = TextStyle(
    color: Color(0xFFD8C924), fontSize: 28.0, fontWeight: FontWeight.bold);

const kBMITextStyle = TextStyle(fontSize: 75, fontWeight: FontWeight.bold);

const kBodyTextStyle = TextStyle(
    fontSize: 22,
    color: Color(0xFFC1CED9),
    fontWeight: FontWeight.bold,
    height: 2.0);

const kSwipeableButtonTextStyle = TextStyle(
  fontWeight: FontWeight.w400,
  fontSize: 21,
  color: Color(0xA0F6F7FF),
  letterSpacing: 1.75,
);
