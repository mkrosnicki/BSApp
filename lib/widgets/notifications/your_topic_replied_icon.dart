import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class YourTopicRepliedIcon extends StatelessWidget {
  const YourTopicRepliedIcon();

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      minRadius: 20,
      maxRadius: 20,
      foregroundColor: Colors.white,
      backgroundColor: Colors.deepOrangeAccent,
      child: Icon(CupertinoIcons.bubble_left),
    );
  }
}
