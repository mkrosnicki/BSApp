import 'package:flutter/material.dart';

import 'app_bar_bottom_border.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget{

  final Color backgroundColor = Colors.red;
  final String title;
  final Widget leading;
  final List<Widget> actions;

  /// you can add more fields that meet your needs

  const BaseAppBar({Key key, this.title, this.actions, this.leading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 8,
      backgroundColor: Colors.white,
      elevation: 0,
      bottom: const AppBarBottomBorder(),
      automaticallyImplyLeading: false,
      centerTitle: true,
      leading: leading,
      actions: actions,
      title: Text(title, style: const TextStyle(color: Colors.black, fontSize: 18),),
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}
