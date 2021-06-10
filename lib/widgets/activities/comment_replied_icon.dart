import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommentRepliedIcon extends StatelessWidget {
  const CommentRepliedIcon();

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      minRadius: 20,
      maxRadius: 20,
      foregroundColor: Colors.white,
      backgroundColor: Colors.deepOrangeAccent,
      child: Icon(CupertinoIcons.reply),
    );
  }
}
