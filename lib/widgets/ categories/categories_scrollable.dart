import 'package:flutter/material.dart';

import 'category_scrollable_item.dart';

class CategoriesScrollable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: double.infinity,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: List.generate(
          20,
              (index) =>
                  CategoryScrollableItem(),
        ),
      ),
    );
  }
}
