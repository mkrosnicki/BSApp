import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarButton extends StatelessWidget {

  final Icon icon;
  final Function onPress;

  const AppBarButton({this.icon, this.onPress});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPress,
      child: icon,
    );
  }
}
