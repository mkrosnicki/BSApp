import 'package:BSApp/models/category_model.dart';
import 'package:BSApp/providers/categories.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'category_scrollable_item.dart';

class CategoriesScrollable extends StatefulWidget {

  final Function refreshFunction;

  const CategoriesScrollable(this.refreshFunction);

  @override
  _CategoriesScrollableState createState() => _CategoriesScrollableState();
}

class _CategoriesScrollableState extends State<CategoriesScrollable> {
  List<CategoryModel> _allCategories = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 8.0),
      child: SizedBox(
        height: 95,
        width: double.infinity,
        child: _allCategories.isNotEmpty
            ? ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) => CategoryScrollableItem(_allCategories[index], widget.refreshFunction),
                itemCount: _allCategories.length,
              )
            : Container(),
      ),
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final categoriesProvider = Provider.of<Categories>(context, listen: false);
      categoriesProvider.fetchCategories().then((_) {
        setState(() {
          _allCategories = categoriesProvider.categories;
        });
      });
    });
    super.initState();
  }
}
