import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/material.dart';

class AppBarBottomBorder extends StatelessWidget
    implements PreferredSizeWidget {
  static const Size aPreferredSize = Size.fromHeight(4.0);

  const AppBarBottomBorder();

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: aPreferredSize,
      child: Container(
        color: MyColorsProvider.GREY_BORDER_COLOR,
        height: 0.8,
      ),
    );
  }

  @override
  Size get preferredSize {
    return aPreferredSize;
  }
}
