import 'package:BSApp/models/filter_settings.dart';
import 'package:BSApp/models/sorting_type.dart';
import 'package:BSApp/screens/common/category_selection_screen.dart';
import 'package:BSApp/screens/deals/filter_selection_screen.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilterSettingsBar extends StatelessWidget {
  final FilterSettings filterSettings;
  final Function(FilterSettings filterSettings) updateFunction;

  const FilterSettingsBar(this.filterSettings, this.updateFunction);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: MyColorsProvider.LIGHT_GRAY),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            // flex: 1,
            child: GestureDetector(
              onTap: () => _openCategorySelector(context),
              behavior: HitTestBehavior.translucent,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: Column(
                  children: [
                    const Text(
                      'Kategoria',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                    Text(
                      filterSettings.categoriesString,
                      // overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 12, color: MyColorsProvider.DEEP_BLUE),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Flexible(
            // flex: 1,
            child: GestureDetector(
              onTap: () => _showFilterSelectionDialog(context),
              behavior: HitTestBehavior.translucent,
              child: Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  border: Border(
                    right: BorderSide(color: MyColorsProvider.GREY_BORDER_COLOR),
                    left: BorderSide(color: MyColorsProvider.GREY_BORDER_COLOR),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      filterSettings.areDefaults() ? 'Filtry' : 'Filtry (${filterSettings.filtersCount()})',
                      style: const TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                    const Text('Zmień', style: TextStyle(fontSize: 12, color: MyColorsProvider.DEEP_BLUE)),
                  ],
                ),
              ),
            ),
          ),
          Flexible(
            // flex: 1,
            child: GestureDetector(
              onTap: () => _showSortingTypeSelector(context),
              behavior: HitTestBehavior.translucent,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: Column(
                  children: [
                    const Text(
                      'Sortuj',
                      style: TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                    Text(
                      filterSettings.sortingString,
                      style: const TextStyle(fontSize: 12, color: MyColorsProvider.DEEP_BLUE),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future _showFilterSelectionDialog(BuildContext context) async {
    final newFilterSettings = await Navigator.of(context).push(MaterialPageRoute<FilterSettings>(
        builder: (BuildContext context) {
          return FilterSelectionScreen();
        },
        settings: RouteSettings(arguments: filterSettings),
        fullscreenDialog: true));
    updateFunction(newFilterSettings);
  }

  Future _openCategorySelector(BuildContext context) async {
    final selectedCategories = await Navigator.of(context).pushNamed(CategorySelectionScreen.routeName);
    if (selectedCategories != null) {
      filterSettings.categories = selectedCategories;
      updateFunction(filterSettings);
    }
  }

  void _showSortingTypeSelector(BuildContext context) {
    const titleTextStyle = TextStyle(fontSize: 13, color: Colors.black87);
    const tileTextStyle = TextStyle(fontSize: 13, color: MyColorsProvider.DEEP_BLUE);
    const cancelTextStyle = TextStyle(fontSize: 13, color: MyColorsProvider.RED_SHADY);
    const checkIcon = Icon(Icons.check, color: MyColorsProvider.DEEP_BLUE, size: 20);
    const paddedIcon = Positioned(top: 12.0, right: 10.0, child: checkIcon);
    showModalBottomSheet(
      context: context,
      // backgroundColor: Colors.transparent,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              title: Center(
                child: Text('Sortuj po', style: titleTextStyle),
              ),
            ),
            InkWell(
              onTap: () => _selectSortingType(context, SortingType.NEWEST),
              child: Container(
                height: 50.0,
                alignment: Alignment.center,
                child: Stack(
                  children: <Widget>[
                    const Align(
                      child: Text('Najnowsze', style: tileTextStyle),
                    ),
                    if (filterSettings.sortBy == SortingType.NEWEST) paddedIcon else Container(),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () => _selectSortingType(context, SortingType.MOST_POPULAR),
              child: Container(
                height: 50.0,
                alignment: Alignment.center,
                child: Stack(
                  children: <Widget>[
                    const Align(
                      child: Text('Najpopularniejsze', style: tileTextStyle),
                    ),
                    if (filterSettings.sortBy == SortingType.MOST_POPULAR) paddedIcon else Container(),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () => _selectSortingType(context, null),
              child: const ListTile(
                title: Center(
                  child: Text(
                    'Anuluj',
                    style: cancelTextStyle,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _selectSortingType(BuildContext context, SortingType sortingType) {
    if (sortingType != null) {
      filterSettings.sortBy = sortingType;
      updateFunction(filterSettings);
    }
    Navigator.pop(context);
  }
}
