import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarBackButton extends StatelessWidget {

  final Color color;
  final Function() function;

  const AppBarBackButton(this.color, {this.function});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        function != null ? function() : Navigator.of(context).pop();
      },
      child: Icon(CupertinoIcons.back, color: color,),
    );
  }
}
