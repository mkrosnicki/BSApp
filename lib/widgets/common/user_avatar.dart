import 'dart:typed_data';

import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final String username;
  final String imagePath;
  final Uint8List image;
  final double radius;
  final Color backgroundColor;

  const UserAvatar({
    this.username,
    this.imagePath,
    this.radius,
    this.backgroundColor,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    final bool useUsername = image == null && imagePath == null;
    final bool useImage = image != null;
    if (useUsername) {
      return CircleAvatar(
        minRadius: radius,
        maxRadius: radius,
        foregroundColor: Colors.white,
        backgroundColor: backgroundColor ?? Colors.deepPurpleAccent,
        child: Text(username.substring(0, 1).toUpperCase()),
      );
    }
    if (useImage) {
      return CircleAvatar(
        minRadius: radius,
        maxRadius: radius,
        foregroundColor: Colors.white,
        backgroundColor: backgroundColor ?? Colors.deepPurpleAccent,
        backgroundImage: MemoryImage(image),
      );
    }
    return CircleAvatar(
      minRadius: radius,
      maxRadius: radius,
      foregroundColor: Colors.white,
      backgroundColor: backgroundColor ?? Colors.deepPurpleAccent,
      backgroundImage: NetworkImage(imagePath),
    );
  }
}
