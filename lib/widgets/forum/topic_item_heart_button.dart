import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopicItemHeartButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Icon(
        CupertinoIcons.heart_fill,
        color: MyColorsProvider.LIGHT_GRAY,
        size: 20,
      ),
    );
  }
}
