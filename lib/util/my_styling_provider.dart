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
      borderSide: BorderSide(width: 0, style: BorderStyle.none),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(width: 0, style: BorderStyle.none),
    ),
  );

  static const InputDecoration TEXT_FIELD_DECORATION = InputDecoration(
    border: InputBorder.none,
    filled: true,
    isDense: true,
    fillColor: MyColorsProvider.SUPER_LIGHT_GREY,
    contentPadding: EdgeInsets.only(
        left: 12.0, right: 12.0, bottom: 8.0, top: 8.0),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(style: BorderStyle.none),
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
          color: MyColorsProvider.SUPER_LIGHT_GREY),
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
  );

  static const Border BOTTOM_GREY_BORDER = Border(bottom: BorderSide(color: MyColorsProvider.GREY_BORDER_COLOR, width: 0.5));
  static const Border TOP_GREY_BORDER = Border(top: BorderSide(color: MyColorsProvider.GREY_BORDER_COLOR, width: 0.2));
  static const Border TOP_BOTTOM_BORDER = Border(top: BorderSide(color: MyColorsProvider.GREY_BORDER_COLOR, width: 0.5), bottom: BorderSide(color: MyColorsProvider.GREY_BORDER_COLOR, width: 0.5));

  static const TextStyle TEXT_BLACK = TextStyle(color: Colors.black87);
  static const TextStyle TEXT_WHITE = TextStyle(color: Colors.white);
  static const TextStyle TEXT_BLUE = TextStyle(color: Colors.blue);
}
