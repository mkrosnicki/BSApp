import 'package:flutter/material.dart';

class CategoryScrollableItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Flex(
        direction: Axis.vertical,
        children: [
          Flexible(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/images/car.png',
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text('Nazwa kategorii', style: TextStyle(fontSize: 12),),
            ),
          )
        ],
      ),
    );
  }
}
