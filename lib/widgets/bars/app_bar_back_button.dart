import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarBackButton extends StatelessWidget {

  final Color color;

  const AppBarBackButton(this.color);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: Icon(CupertinoIcons.back, color: color,),
    );
  }
}
