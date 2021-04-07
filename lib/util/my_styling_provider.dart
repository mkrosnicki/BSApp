import 'package:flutter/material.dart';

import 'my_colors_provider.dart';

class MyStylingProvider {
  static const InputDecoration TEXT_FORM_FIELD_DECORATION = InputDecoration(
    enabledBorder: InputBorder.none,
    focusedErrorBorder: InputBorder.none,
    filled: true,
    fillColor: MyColorsProvider.SUPER_LIGHT_GREY,
    focusColor: MyColorsProvider.SUPER_LIGHT_GREY,
    border: UnderlineInputBorder(
      borderSide: const BorderSide(width: 0, style: BorderStyle.none),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: const BorderSide(width: 0),
    ),
  );

  static InputDecoration textFormFieldDecoration() {
    return InputDecoration(
      enabledBorder: InputBorder.none,
      focusedErrorBorder: InputBorder.none,
      filled: true,
      fillColor: MyColorsProvider.SUPER_LIGHT_GREY,
      focusColor: MyColorsProvider.SUPER_LIGHT_GREY,
      border: UnderlineInputBorder(
        borderSide: const BorderSide(width: 0, style: BorderStyle.none),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: const BorderSide(width: 0),
      ),
    );
  }

  static const Border GREY_BORDER = Border(bottom: const BorderSide(color: MyColorsProvider.GREY_BORDER_COLOR, width: 0.5));
  static const Border TOP_GREY_BORDER = const Border(top: const BorderSide(color: MyColorsProvider.GREY_BORDER_COLOR, width: 0.2));

  static const TextStyle TEXT_BLACK = const TextStyle(color: Colors.black87);
  static const TextStyle TEXT_WHITE = const TextStyle(color: Colors.white);
  static const TextStyle TEXT_BLUE = const TextStyle(color: Colors.blue);
}
