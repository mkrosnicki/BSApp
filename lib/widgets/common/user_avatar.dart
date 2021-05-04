import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {

  final String username;
  final String imagePath;
  final Image image;
  final double radius;
  final Color backgroundColor;

  UserAvatar({
    this.username,
    this.imagePath,
    this.radius,
    this.backgroundColor,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    final bool useUsername = image == null && imagePath == null;
    final bool useImage = imagePath == null && imagePath != null;
    if (useUsername) {
      return CircleAvatar(
        minRadius: radius,
        maxRadius: radius,
        foregroundColor: Colors.white,
        backgroundColor: backgroundColor != null ? backgroundColor : MyColorsProvider.DEEP_BLUE,
        child: Text(username.substring(0, 1)),
      );
    }
    if (useImage) {
      return CircleAvatar(
        minRadius: radius,
        maxRadius: radius,
        foregroundColor: Colors.white,
        backgroundColor: backgroundColor != null ? backgroundColor : MyColorsProvider.DEEP_BLUE,
        backgroundImage: NetworkImage(imagePath),
      );
    }
    return CircleAvatar(
      minRadius: radius,
      maxRadius: radius,
      foregroundColor: Colors.white,
      backgroundColor: backgroundColor != null ? backgroundColor : MyColorsProvider.DEEP_BLUE,
      backgroundImage: NetworkImage(imagePath),
    );

  }
}
