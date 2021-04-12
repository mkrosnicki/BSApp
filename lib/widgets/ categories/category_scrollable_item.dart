import 'package:BSApp/models/category_model.dart';
import 'package:BSApp/models/filter_settings.dart';
import 'package:BSApp/screens/deals/deal_search_result_screen.dart';
import 'package:flutter/material.dart';

class CategoryScrollableItem extends StatelessWidget {

  final CategoryModel categoryModel;

  CategoryScrollableItem(this.categoryModel);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.of(context).pushNamed(DealSearchResultScreen.routeName,
              arguments: FilterSettings.categories([categoryModel])),
      child: Container(
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
                  'assets/images/${CategoryModelHelper.assetNameFor(
                      categoryModel)}',
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  categoryModel.name, style: TextStyle(fontSize: 12),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
