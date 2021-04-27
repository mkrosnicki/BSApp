import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostAddedIcon extends StatelessWidget {

  const PostAddedIcon();

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      minRadius: 20,
      maxRadius: 20,
      foregroundColor: Colors.white,
      backgroundColor: MyColorsProvider.DEEP_BLUE,
      child: Icon(CupertinoIcons.reply),
    );
  }
}
