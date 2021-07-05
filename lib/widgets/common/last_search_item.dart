import 'package:BSApp/models/filter_settings.dart';
import 'package:BSApp/screens/deals/deal_search_result_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LastSearchItem extends StatelessWidget {
  final FilterSettings filterSettings;
  final Function() removeFunction;

  const LastSearchItem(this.filterSettings, this.removeFunction);

  @override
  Widget build(BuildContext context) {
    final filtersString = _getFiltersString();
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(DealSearchResultScreen.routeName, arguments: filterSettings),
      child: Container(
        color: Colors.white,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(12.0),
        margin: const EdgeInsets.only(bottom: 6.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 2.0),
                  child: Wrap(
                    children: [
                      if (filterSettings.phrase != null)
                        const Text(
                          'Wyszukiwana fraza ',
                          style: TextStyle(fontSize: 12),
                        ),
                      if (filterSettings.phrase != null)
                        Text(
                          filterSettings.phrase,
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                      if (filterSettings.phrase == null)
                        const Text(
                          'Brak wyszukiwanej frazy',
                          style: TextStyle(fontSize: 12, height: 1.4),
                        ),
                    ],
                  ),
                ),
                if (filtersString != null)
                  Text(
                    filtersString,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.black54,
                      height: 1.2
                    ),
                  ),
              ],
            ),
            InkWell(
              onTap: removeFunction,
              child: const Icon(
                CupertinoIcons.clear,
                size: 18,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getFiltersString() {
    final List<String> filtersSet = _getFiltersSet();
    final numberOfFilters = filtersSet.length;
    if (numberOfFilters == 0) {
      return 'Brak innych filtrów';
    } else if (numberOfFilters <= 2) {
      return filtersSet.join(", ");
    } else {
      return '${filtersSet.sublist(0, 2).join(", ")} oraz inne filtry (${numberOfFilters - 2})';
    }
  }

  List<String> _getFiltersSet() {
    final List<String> filtersSet = [];
    if (filterSettings.category != null) {
      filtersSet.add(filterSettings.lastCategoryString);
    }
    if (filterSettings.voivodeship != null) {
      filtersSet.add(filterSettings.simpleLocationString);
    }
    if (filterSettings.ageTypes.isNotEmpty) {
      filtersSet.add(filterSettings.ageTypesShortString);
    }
    if (filterSettings.showInternetOnly != FilterSettings.DEFAULT_SHOW_INTERNET_ONLY) {
      filtersSet.add('Tylko internetowe');
    }
    if (filterSettings.showActiveOnly != FilterSettings.DEFAULT_SHOW_ACTIVE_ONLY) {
      filtersSet.add('Tylko aktywne');
    }
    if (filterSettings.sortBy != FilterSettings.DEFAULT_SORTING_TYPE) {
      filtersSet.add(filterSettings.sortingString);
    }
    return filtersSet;
  }
}
