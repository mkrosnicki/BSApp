import 'package:BSApp/providers/categories.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'category_scrollable_item.dart';

class CategoriesScrollable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      width: double.infinity,
      child: FutureBuilder(
        future:
            Provider.of<Categories>(context, listen: false).fetchCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.error != null) {
              return Center(
                child: Text('An error occurred!'),
              );
            } else {
              return Consumer<Categories>(
                builder: (context, categoriesData, child) => ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) =>
                      CategoryScrollableItem(categoriesData.categories[index]),
                  itemCount: categoriesData.categories.length,
                ),
              );
            }
          }
        },
      ),
    );
  }
}
