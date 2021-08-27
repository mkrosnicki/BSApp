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
    contentPadding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 8.0, top: 8.0),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(style: BorderStyle.none),
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: MyColorsProvider.SUPER_LIGHT_GREY),
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
    hintStyle: TextStyle(color: Colors.black87)
  );

  static const InputDecoration POST_COMMENT_BOTTOM_TEXT_FIELD_DECORATION = InputDecoration(
    border: InputBorder.none,
    isDense: true,
    contentPadding: EdgeInsets.only(left: 12.0, right: 40.0, bottom: 8.0, top: 8.0),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: MyColorsProvider.LIGHT_GRAY),
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: MyColorsProvider.LIGHT_GRAY),
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
  );

  static InputDecoration textFormFiledDecorationWithLabelText(String labelText) {
    return InputDecoration(
      hintText: labelText,
      hintStyle: const TextStyle(fontSize: 14, color: Colors.black87),
      contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      border: InputBorder.none,
      suffixIconConstraints: const BoxConstraints(maxHeight: 20.0, minWidth: 25.0),
      filled: true,
      isDense: true,
      fillColor: MyColorsProvider.SUPER_LIGHT_GREY,
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: MyColorsProvider.SUPER_LIGHT_GREY),
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        borderSide: BorderSide(style: BorderStyle.none),
      ),
      errorStyle: const TextStyle(fontSize: 11),
    );
  }

  static const Border BOTTOM_GREY_BORDER =
      Border(bottom: BorderSide(color: MyColorsProvider.GREY_BORDER_COLOR, width: 0.5));
  static const Border TOP_GREY_BORDER = Border(top: BorderSide(color: MyColorsProvider.GREY_BORDER_COLOR, width: 0.5));
  static const Border TOP_GREY_BORDER_THICK = Border(top: BorderSide(color: MyColorsProvider.GREY_BORDER_COLOR, width: 1.0));
  static const Border TOP_BOTTOM_BORDER = Border(
      top: BorderSide(color: MyColorsProvider.GREY_BORDER_COLOR, width: 0.5),
      bottom: BorderSide(color: MyColorsProvider.GREY_BORDER_COLOR, width: 0.5));

  static const TextStyle TEXT_BLACK = TextStyle(color: Colors.black87);
  static const TextStyle TEXT_WHITE = TextStyle(color: Colors.white);
  static const TextStyle TEXT_BLUE = TextStyle(color: Colors.blue);

  static const TextStyle SELECTED_TAB_TEXT_STYLE = TextStyle(color: Colors.black, fontSize: 12);
  static const TextStyle UNSELECTED_TAB_TEXT_STYLE = TextStyle(color: Colors.black, fontSize: 12);

  static const BoxDecoration DEFAULT_TAB_BAR_DECORATION = BoxDecoration(color: Colors.white, border: Border(bottom: BorderSide(color: MyColorsProvider.LIGHT_GRAY)));
  static const EdgeInsets ITEMS_MARGIN = EdgeInsets.only(top: 5.0, left: 6.0, right: 6.0);
  static const BoxDecoration ITEMS_BORDER = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
    border: Border(
      left: BorderSide(color: MyColorsProvider.GREY_BORDER_COLOR, width: 0.5),
      right: BorderSide(color: MyColorsProvider.GREY_BORDER_COLOR, width: 0.5),
      top: BorderSide(color: MyColorsProvider.GREY_BORDER_COLOR, width: 0.5),
      bottom: BorderSide(color: MyColorsProvider.GREY_BORDER_COLOR, width: 0.5),
    ),
  );
}
