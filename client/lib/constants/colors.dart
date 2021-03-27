import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

class CustomColors {
  static const appColorGrey = Color(0xff333333);
  static const appColorLightGrey = Color(0xffe7e7e7);
  static const appColorBlue = Color(0xff63c4ed);
  static const appColorLightBlue = Color(0xfff1f9fc);
  static const appColorRed = Color(0xfff5360b);
  static const appColorTeal = Color(0xff159599);
  static const appColorOrange = Color(0xffEF8F6B);

  //randomcolor
  static final Random _random = new Random();

  /// Returns a random color.
  static Color next() {
    return new Color(0xFF000000 + _random.nextInt(0x00FFFFFF));
  }
}
