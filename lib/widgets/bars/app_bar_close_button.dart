import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarCloseButton extends StatelessWidget {

  final Color color;

  AppBarCloseButton(this.color);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: TextButton(
        child: Icon(CupertinoIcons.clear, color: color,),
      ),
    );
  }
}
