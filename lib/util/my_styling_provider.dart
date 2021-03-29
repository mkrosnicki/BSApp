import 'package:flutter/material.dart';

import 'my_colors_provider.dart';

class MyStylingProvider {

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

}