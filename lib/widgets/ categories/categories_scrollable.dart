import 'package:BSApp/models/category_model.dart';
import 'package:flutter/material.dart';

import 'category_scrollable_item.dart';

class CategoriesScrollable extends StatelessWidget {
  final List<CategoryModel> allCategories;

  const CategoriesScrollable(this.allCategories);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 4.0),
      child: SizedBox(
          height: 95,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) =>
                CategoryScrollableItem(allCategories[index]),
            itemCount: allCategories.length,
          )),
    );
  }
}
