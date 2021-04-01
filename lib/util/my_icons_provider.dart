import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyIconsProvider {

  static const Icon NONE = Icon(null);

  static const Icon FORWARD_ICON = Icon(CupertinoIcons.chevron_right,);
  static const Icon FORWARD_BLACK_ICON = Icon(CupertinoIcons.chevron_right, color: Colors.black);
  static const Icon FORWARD_WHITE_ICON = Icon(CupertinoIcons.chevron_right, color: Colors.white);

  static const Icon BACK_ICON = Icon(CupertinoIcons.back);
  static const Icon BACK_BLACK_ICON = Icon(CupertinoIcons.back, color: Colors.black);
  static const Icon BACK_WHITE_ICON = Icon(CupertinoIcons.back, color: Colors.white);

  static const Icon CLEAR_BLACK_ICON = Icon(CupertinoIcons.clear, color: Colors.black);
  static const Icon CLEAR_WHITE_ICON = Icon(CupertinoIcons.clear, color: Colors.white);

}