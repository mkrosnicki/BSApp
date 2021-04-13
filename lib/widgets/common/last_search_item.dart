import 'package:flutter/material.dart';

class LastSearchItem extends StatelessWidget {

  final int index;

  LastSearchItem(this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text('Wyszukiwanie numer ${index}'),
    );
  }
}
