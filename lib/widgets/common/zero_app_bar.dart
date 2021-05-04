import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/material.dart';

class ZeroAppBar extends StatelessWidget implements PreferredSizeWidget {

  const ZeroAppBar();

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(0.0),
      child: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        // leading: const AppBarBackButton(Colors.black),
        // bottom: AppBarBottomBorder(),
      ),
    );
  }

  @override
  Size get preferredSize {
    return Size.fromHeight(0.0);
  }
}
