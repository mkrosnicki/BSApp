import 'package:flutter/material.dart';

class DealItem extends StatelessWidget {
  final String id;
  final String title;

  DealItem({this.id, this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(id),
        Text(title),
        Text(title),
        Text(title),
        Text(title),
        Text(title),
        Text(title),
        Text(title),
        Text(title),
        Text(title),
        Text(title),
        Text(title),
        Text(title),
        Text(title),
        Text(title),
        Text(title),
        Text(title),
      ],
    );
  }
}
