import 'package:BSApp/models/filter_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LastSearchItem extends StatelessWidget {
  final FilterSettings filterSettings;
  final Function removeFunction;

  LastSearchItem(this.filterSettings, this.removeFunction);

  @override
  Widget build(BuildContext context) {
    var filtersString = _getFiltersString();
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.only(bottom: 4.0),
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
                    const Text(
                      'Wyszukiwana fraza ',
                      style: const TextStyle(fontSize: 12),
                    ),
                    Text(
                      '${filterSettings.phrase}',
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              if (filtersString != null) Text(
                filtersString,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          InkWell(
            onTap: removeFunction,
            child: const Icon(
              CupertinoIcons.clear,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }

  _getFiltersString() {
    List<String> filtersSet = _getFiltersSet();
    var numberOfFilters = filtersSet.length;
    if (numberOfFilters == 0) {
      return 'Brak innych filtrów';
    } else if (numberOfFilters <= 2) {
      return filtersSet.join(", ");
    } else {
      return '${filtersSet.sublist(0, 2).join(", ")} oraz inne filtry (${numberOfFilters - 2})';
    }
  }

  List<String> _getFiltersSet() {
    List<String> filtersSet = [];
    if (filterSettings.categories.isNotEmpty) {
      filtersSet.add(filterSettings.lastCategoryString);
    }
    if (filterSettings.voivodeship != null) {
      filtersSet.add(filterSettings.simpleLocationString);
    }
    if (filterSettings.ageTypes.isNotEmpty) {
      filtersSet.add(filterSettings.ageTypesShortString);
    }
    if (filterSettings.showInternetOnly !=
        FilterSettings.DEFAULT_SHOW_INTERNET_ONLY) {
      filtersSet.add('Tylko Internetowe');
    }
    if (filterSettings.showActiveOnly !=
        FilterSettings.DEFAULT_SHOW_ACTIVE_ONLY) {
      filtersSet.add('Tylko Aktywne');
    }
    if (filterSettings.sortBy != FilterSettings.DEFAULT_SORTING_TYPE) {
      filtersSet.add(filterSettings.sortingString);
    }
    return filtersSet;
  }


}
