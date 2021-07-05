import 'package:flutter/material.dart';

class ZeroAppBar extends StatelessWidget implements PreferredSizeWidget {

  const ZeroAppBar();

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(0.0),
      child: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        // leading: const AppBarBackButton(Colors.white),
        // bottom: AppBarBottomBorder(),
      ),
    );
  }

  @override
  Size get preferredSize {
    return const Size.fromHeight(0.0);
  }
}
