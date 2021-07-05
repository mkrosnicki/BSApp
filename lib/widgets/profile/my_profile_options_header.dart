import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/material.dart';

class MyProfileOptionsHeader extends StatelessWidget {

  final String title;

  const MyProfileOptionsHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 12,
          color: MyColorsProvider.DEEP_BLUE,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
