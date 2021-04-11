import 'package:flutter/material.dart';

import 'category_scrollable_item.dart';

class CategoriesScrollable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: List.generate(
            20,
                (index) =>
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(8.0),
                  child: CategoryScrollableItem(),
                ),
          ),
        ),
      ),
    );
  }
}
