import 'package:BSApp/models/category_model.dart';
import 'package:BSApp/models/filter_settings.dart';
import 'package:BSApp/screens/deals/deal_search_result_screen.dart';
import 'package:BSApp/util/image_assets_helper.dart';
import 'package:flutter/material.dart';

class CategoryScrollableItem extends StatelessWidget {
  final CategoryModel categoryModel;
  final Function refreshFunction;

  const CategoryScrollableItem(this.categoryModel, this.refreshFunction);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _navigateToResults(context);
      },
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Flex(
          direction: Axis.vertical,
          children: [
            Container(
              height: 55,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Image.asset(
                  ImageAssetsHelper.productCategoryPath(categoryModel.name),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Text(
                  _getShrinked(categoryModel.name),
                  style: const TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  String _getShrinked(String name) {
    if (name.contains(' i ')) {
      return name.replaceFirst(' i ', ' i\n ');
    }
    if (name.contains(' ')) {
      return name.replaceFirst(' ', ' \n ');
    }
    return name;
  }

  Future _navigateToResults(BuildContext context) async {
    var result = await Navigator.of(context).pushNamed(
        DealSearchResultScreen.routeName,
        arguments: FilterSettings.categories([categoryModel]));
    if (result != null && result == true) {
      refreshFunction(context);
    }
  }
}
