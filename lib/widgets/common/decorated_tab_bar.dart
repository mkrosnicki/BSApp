import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/material.dart';

class DecoratedTabBar extends StatelessWidget implements PreferredSizeWidget {
  const DecoratedTabBar({@required this.tabBar, @required this.decoration});

  final TabBar tabBar;
  final BoxDecoration decoration;

  @override
  Size get preferredSize => tabBar.preferredSize;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: Container(
              decoration: decoration ??
              const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: MyColorsProvider.LIGHT_GRAY),
                ),
              ),
        )),
        tabBar,
      ],
    );
  }
}
