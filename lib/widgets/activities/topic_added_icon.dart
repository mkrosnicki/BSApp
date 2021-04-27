import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopicAddedIcon extends StatelessWidget {

  const TopicAddedIcon();

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      minRadius: 20,
      maxRadius: 20,
      foregroundColor: Colors.white,
      backgroundColor: MyColorsProvider.DEEP_BLUE,
      child: Icon(CupertinoIcons.bubble_left_bubble_right),
    );
  }
}
