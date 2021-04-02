import 'package:BSApp/util/my_styling_provider.dart';
import 'package:flutter/material.dart';

import 'app_bar_bottom_border.dart';

class AppBarAddDeal extends StatelessWidget implements PreferredSizeWidget {

  static const Size _aPreferredSize = Size.fromHeight(50.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Dodaj nową okazję',
        style: MyStylingProvider.TEXT_BLACK,
      ),
      automaticallyImplyLeading: false,
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.white,
      bottom: const AppBarBottomBorder(),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => _aPreferredSize;
}
