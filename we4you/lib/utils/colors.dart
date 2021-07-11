import 'dart:ui';
import 'package:flutter/material.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

// text color
const kcText = Color(0xff000000);
const kcTextLight = Color(0xffA2AECD);

// border color
const kcBorder = Color(0xffC8D7E5);

const kcBackground = Color(0xffffbb9d);

const kcTurquoice = Color(0xFF039381);
const kcLightTurquoice = Color(0xFFC7F2F5);
const kcOrange = Color(0xFFE16C00);
const kcLightOrange = Color(0xFFFFDAB7);

const kcAppBackground = Color(0xFFF9FCFF);
