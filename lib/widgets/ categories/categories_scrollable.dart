import 'package:BSApp/models/category_model.dart';
import 'package:BSApp/providers/categories.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'category_scrollable_item.dart';

class CategoriesScrollable extends StatelessWidget {
  List<CategoryModel> _allCategories;

  Future<void> _initCategories(BuildContext context) {
    if (_allCategories == null) {
      return Provider.of<Categories>(context, listen: false)
          .fetchCategories()
          .then((_) {
        _allCategories =
            Provider.of<Categories>(context, listen: false).categories;
      });
    } else {
      return Future(() => {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
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

// ListView(
// shrinkWrap: true,
// scrollDirection: Axis.horizontal,
// children: List.generate(
// 10,
// (index) => CategoryScrollableItem(categoriesData.categories[index]),
// ),
// )

}
