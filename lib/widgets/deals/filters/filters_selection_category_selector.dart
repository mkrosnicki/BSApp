import 'package:BSApp/models/category_model.dart';
import 'package:BSApp/util/image_assets_helper.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FiltersSelectionCategorySelector extends StatelessWidget {
  final List<CategoryModel> categories;
  final GestureTapCallback onTap;

  const FiltersSelectionCategorySelector(this.categories, this.onTap);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: SizedBox(
                    height: 30.0,
                    child: Image.asset(
                      categories != null && categories.isNotEmpty
                          ? ImageAssetsHelper.productCategoryPath(categories[0].name)
                          : ImageAssetsHelper.categoryPlaceholderPath(),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Kategoria',
                      style: TextStyle(fontSize: 11, color: Colors.grey, height: 1.3),
                    ),
                    Text(
                      categories != null && categories.isNotEmpty ? categories[0].name : "Dowolna",
                      style: const TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Icon(
              CupertinoIcons.chevron_right,
              color: MyColorsProvider.DEEP_BLUE,
            )
          ],
        ),
      ),
    );
  }
}
