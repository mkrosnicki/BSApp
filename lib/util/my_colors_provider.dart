import 'package:flutter/material.dart';

class MyColorsProvider {

  static const BLUE = Color.fromRGBO(47, 183, 237, 1.0);
  static const DEEP_BLUE = Color.fromRGBO(0, 152, 211, 1.0);

  static const GREEN = Color.fromRGBO(40, 167, 69, 1.0);

  static const GREY_BORDER_COLOR = Color.fromRGBO(212, 227, 235, 1);

  static const SUPER_LIGHT_GREY = Color.fromRGBO(245, 245, 245, 1.0);

  static const BACKGROUND_COLOR = Color.fromRGBO(245, 245, 245, 1);

  static const Color LIGHT_GRAY = Color.fromRGBO(224, 224, 224, 1.0);
  static const Color RED_SHADY = Color.fromRGBO(255, 128, 128, 1.0);
  static const Color LIGHT_RED_SHADY = Color.fromRGBO(255, 128, 128, 0.7);
  static final Color GREEN_SHADY = Colors.green.shade400.withOpacity(0.6);

  static Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

}