import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarCloseButton extends StatelessWidget {

  final Color color;

  const AppBarCloseButton(this.color);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.of(context).pop(),
      child: Icon(CupertinoIcons.clear, color: color,),
    );
  }
}
