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
      backgroundColor: Colors.deepPurpleAccent,
      child: Icon(CupertinoIcons.reply),
    );
  }
}
