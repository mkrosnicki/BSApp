import 'package:flutter/material.dart';

class MyColorsProvider {

  static const BLUE = Color.fromRGBO(47, 183, 237, 1.0);
  static const DEEP_BLUE = Color.fromRGBO(0, 152, 211, 1.0);

  static const GREEN = Color.fromRGBO(40, 167, 69, 1.0);

  static const GREY_BORDER_COLOR = Color.fromRGBO(212, 227, 235, 1);

  static Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

}