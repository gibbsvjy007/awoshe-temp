import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

const Color primaryColor = const Color.fromRGBO(234, 132, 57, 1.0);
const Color secondaryColor = const Color.fromRGBO(71, 94, 109, 1.0);

/// #475E6D
const Color awDarkColor = const Color.fromRGBO(71, 94, 109, 1.0);
const Color awLightColor = const Color.fromRGBO(179, 193, 201, 1.0);
const Color awYellowColor = const Color.fromRGBO(254, 207, 17, 1.0);
const Color awMessageWidgetColor = const Color.fromRGBO(233, 237, 239, 1.0);
const Color awLightColor300 = const Color.fromRGBO(179, 193, 201, 0.3);

final Color shimmerBaseColor = Colors.grey[300];
final Color shimmerHighlightColor = Colors.grey[100];

/// #B3C1C9awLightColor
const Color awBlack = const Color.fromRGBO(37, 48, 56, 1.0);

/// #253038
const Color awGreen = const Color.fromRGBO(40, 180, 70, 1.0);
ThemeData appTheme = new ThemeData(
  fontFamily: 'Muli',
  hintColor: awLightColor,
  primaryColor: Colors.white,
  //brightness: Brightness.light,

  accentColor: awLightColor,
  canvasColor: const Color(0xFFFFFFFF),
  textTheme: Typography(platform: defaultTargetPlatform).black.apply(
    bodyColor: Color.fromRGBO(71, 94, 109, 1.0),
    displayColor: secondaryColor, fontFamily: 'Muli',
  ),
);

const TextStyle textStyle = const TextStyle(
    color: secondaryColor, fontSize: 16.0, fontWeight: FontWeight.w600);

const TextStyle textStyle14 = const TextStyle(
    color: secondaryColor, fontSize: 16.0, fontWeight: FontWeight.w500);

const TextStyle upperTabbarTextStyle = const TextStyle(
    fontSize: 16.0, color: awLightColor, fontWeight: FontWeight.w300, );

const TextStyle textStyle1 = const TextStyle(
    color: secondaryColor, fontSize: 18.0, fontWeight: FontWeight.w500);

const TextStyle textStyle2 = const TextStyle(
    color: secondaryColor, fontSize: 20.0, fontWeight: FontWeight.w600);

const TextStyle textStyle3 = const TextStyle(
    color: secondaryColor, fontSize: 22.0, fontWeight: FontWeight.w600);

const TextStyle textStyle4 = const TextStyle(
    color: secondaryColor, fontSize: 24.0, fontWeight: FontWeight.w600);

const TextStyle textStyleLargeSec = const TextStyle(
    color: secondaryColor, fontSize: 40.0, fontWeight: FontWeight.w600);

const TextStyle textStyleLargeBlack = const TextStyle(
    color: awBlack, fontSize: 40.0, fontWeight: FontWeight.w600);

const TextStyle textStyleLight1 = const TextStyle(
    color: awLightColor, fontSize: 14.0, fontWeight: FontWeight.w600);

const TextStyle textStyle14sec = const TextStyle(
    color: secondaryColor, fontSize: 14.0, fontWeight: FontWeight.w600);

const TextStyle textStyle12sec = const TextStyle(
  color: secondaryColor,
  fontSize: 12.0,
  fontWeight: FontWeight.w600,
);

const TextStyle textStyle12light = const TextStyle(
  color: awLightColor,
  fontSize: 12.0,
  fontWeight: FontWeight.w600,
);


TextStyle notificationTitleStyle = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    color: Colors.black);

const TextStyle textStyleLight2 = const TextStyle(
    color: awLightColor, fontSize: 16.0, fontWeight: FontWeight.w600);

const TextStyle boldText = const TextStyle(
    color: secondaryColor, fontSize: 16.0, fontWeight: FontWeight.w600);

const TextStyle lightText = const TextStyle(
    color: awLightColor, fontSize: 16.0, fontWeight: FontWeight.normal);

const TextStyle lightBoldText = const TextStyle(
    color: awLightColor, fontSize: 16.0, fontWeight: FontWeight.w600);

TextStyle appBarTextStyle =
    const TextStyle(color: secondaryColor, fontWeight: FontWeight.w500);

Color textFieldColor = Colors.white;

TextStyle buttonTextStyle = const TextStyle(
    color: Colors.white,
    fontSize: 14.0,
    fontFamily: "Muli",
    fontWeight: FontWeight.w600);

TextStyle buttonTextWithUnderlineStyle = const TextStyle(
    color: Colors.white,
    decorationStyle: TextDecorationStyle.solid,
    fontSize: 14.0,
    fontFamily: "Muli",
    decoration: TextDecoration.underline,
    fontWeight: FontWeight.w600);

TextStyle hintStyle = const TextStyle(color: awLightColor);
