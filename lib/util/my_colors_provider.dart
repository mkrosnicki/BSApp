import 'package:flutter/material.dart';

class MyColorsProvider {

  static const LIGHT_BLUE = Color.fromRGBO(219, 239, 250, 1.0); //45 180 235
  static const BLUE = Color.fromRGBO(45, 180, 235, 1.0); //45 180 235
  static const DEEP_BLUE = Color.fromRGBO(0, 150, 210, 1.0);

  static const GREEN = Color.fromRGBO(40, 167, 69, 1.0);

  static const GREY_BORDER_COLOR = Color.fromRGBO(212, 227, 235, 1);

  static const SUPER_LIGHT_GREY = Color.fromRGBO(245, 245, 245, 1.0);

  static const BACKGROUND_COLOR = Color.fromRGBO(245, 245, 245, 1);

  static const Color LIGHT_GRAY = Color.fromRGBO(224, 224, 224, 1.0);
  static const Color RED_SHADY = Color.fromRGBO(255, 128, 128, 1.0);
  static const Color LIGHT_RED_SHADY = Color.fromRGBO(255, 128, 128, 0.7);
  static const Color GREEN_SHADY = Color.fromRGBO(102, 187, 106, 0.6);
  static const Color GREEN_LIGHT_SHADY = Color.fromRGBO(102, 187, 106, 0.9);

  static Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

}