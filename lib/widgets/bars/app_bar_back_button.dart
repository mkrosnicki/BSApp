import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarBackButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: TextButton(
        child: Icon(CupertinoIcons.back, color: Colors.black,),
      ),
    );
  }
}
