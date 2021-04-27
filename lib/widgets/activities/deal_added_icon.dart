import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DealAddedIcon extends StatelessWidget {

  const DealAddedIcon();

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      minRadius: 20,
      maxRadius: 20,
      foregroundColor: Colors.white,
      backgroundColor: MyColorsProvider.GREEN_LIGHT_SHADY,
      child: Icon(CupertinoIcons.money_dollar),
    );
  }
}
