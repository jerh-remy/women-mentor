import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

class CustomColors {
  // static const appPrimaryColor = Color(0xff0047dc);
  static const appColorGrey = Color(0xff333333);

  static const appColorLightGrey = Color(0xffe7e7e7);
  static const appColorBlue = Color(0xff63c4ed);
  static const appColorLightBlue = Color(0xfff1f9fc);

  static const appColorTeal = Color(0xff159599);
  static const appColorOrange = Color(0xffEF8F6B);

  static List<Color> kitGradients = [
    // new Color.fromRGBO(103, 218, 255, 1.0),
    // new Color.fromRGBO(3, 169, 244, 1.0),
    // new Color.fromRGBO(0, 122, 193, 1.0),
    Colors.blueGrey.shade800,
    Colors.black87,
  ];
  static List<Color> kitGradients2 = [
    Colors.cyan.shade600,
    Colors.blue.shade900
  ];

  //randomcolor
  static final Random _random = new Random();

  /// Returns a random color.
  static Color next() {
    return new Color(0xFF000000 + _random.nextInt(0x00FFFFFF));
  }
}
