import 'package:flutter/material.dart';

class CategoryScrollableItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(8.0),
      child: Image.asset(
        'assets/images/car.png',
        fit: BoxFit.fitHeight,
      ),
    );
  }
}
