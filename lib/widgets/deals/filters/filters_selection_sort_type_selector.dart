import 'package:BSApp/models/age_type.dart';
import 'package:BSApp/models/filter_settings.dart';
import 'package:BSApp/models/sorting_type.dart';
import 'package:BSApp/util/image_assets_helper.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FiltersSelectionSortTypeSelector extends StatelessWidget {
  final FilterSettings filterSettings;
  final Function(SortingType) onTap;

  const FiltersSelectionSortTypeSelector(this.filterSettings, this.onTap);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _changeSortType(),
      child: Container(
        // margin: const EdgeInsets.only(left: 16),
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
                      ImageAssetsHelper.sortingIconPath(),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Sortowanie',
                      style: TextStyle(fontSize: 11, color: Colors.grey, height: 1.3),
                    ),
                    Text(
                      SortingTypeHelper.getReadableC(filterSettings.sortBy),
                      style: const TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Icon(
              CupertinoIcons.arrow_2_circlepath,
              color: MyColorsProvider.DEEP_BLUE,
            )
          ],
        ),
      ),
    );
  }

  void _changeSortType() {
    onTap(filterSettings.sortBy == SortingType.NEWEST ? SortingType.MOST_POPULAR : SortingType.NEWEST);
  }

}
