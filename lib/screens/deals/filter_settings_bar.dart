import 'package:BSApp/models/filter_settings.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/material.dart';

import 'filter_selection_screen.dart';

class FilterSettingsBar extends StatelessWidget {
  final FilterSettings filterSettings;
  final Function(FilterSettings filterSettings) updateFunction;

  const FilterSettingsBar(this.filterSettings, this.updateFunction);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            // flex: 1,
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
          Flexible(
            // flex: 1,
            child: GestureDetector(
              onTap: () => _showFilterSelectionDialog(context),
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
}
