import 'package:flutter/material.dart';

class ProfileOptionItem extends StatelessWidget {
  final String title;
  final String route;

  ProfileOptionItem(this.title, this.route);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(title),
    );
  }
}
