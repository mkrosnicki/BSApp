import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/material.dart';

import 'app_bar_bottom_border.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  MaterialColor get backgroundColor => Colors.red;
  final String title;
  final Widget leading;
  final PreferredSizeWidget bottom;
  final List<Widget> actions;

  /// you can add more fields that meet your needs

  const BaseAppBar(
      {Key key, this.title, this.actions, this.leading, this.bottom})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 8,
      backgroundColor: MyColorsProvider.PASTEL_BLUE,
      elevation: 0,
      bottom: bottom ?? const AppBarBottomBorder(),
      automaticallyImplyLeading: false,
      centerTitle: true,
      leading: leading,
      actions: actions,
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
