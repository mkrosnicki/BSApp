import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {

  final String username;
  final String imagePath;
  final double radius;
  final Color backgroundColor;

  UserAvatar({
    this.username,
    this.imagePath,
    this.radius,
    this.backgroundColor
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      minRadius: radius,
      maxRadius: radius,
      foregroundColor: Colors.white,
      backgroundColor: backgroundColor != null ? backgroundColor : Colors.green,
      child: Text(username.substring(0, 1)),
    );
  }
}
