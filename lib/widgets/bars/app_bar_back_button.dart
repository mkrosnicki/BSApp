import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarBackButton extends StatelessWidget {

  final Color color;

  const AppBarBackButton(this.color);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: TextButton(
        child: Icon(CupertinoIcons.back, color: color,),
      ),
    );
  }
}
