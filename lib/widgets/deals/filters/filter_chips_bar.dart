import 'package:BSApp/models/filter_settings.dart';
import 'package:BSApp/widgets/common/selected_filter_chip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilterChipsBar extends StatelessWidget {
  final FilterSettings filterSettings;
  final Function(FilterSettings filterSettings) updateFunction;

  const FilterChipsBar(this.filterSettings, this.updateFunction);

  @override
  Widget build(BuildContext context) {
    return !filterSettings.areDefaults()
        ? Container(
            color: Colors.white,
            width: double.infinity,
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              // direction: Axis.vertical,
              children: _buildFilterChips(),
            ),
          )
        : Container();
  }

  List<Widget> _buildFilterChips() {
    final List<Widget> chips = [];
    if (filterSettings.showInternetOnly != FilterSettings.DEFAULT_SHOW_INTERNET_ONLY) {
      chips.add(
        SelectedFilterChip(
          label: 'Tylko Internetowe',
          onDeleteFunction: () => _clearFilterSettings(clearInternetOnly: true),
        ),
      );
    }
    if (filterSettings.categories.isNotEmpty) {
      chips.add(
        SelectedFilterChip(
          label: filterSettings.lastCategoryString,
          onDeleteFunction: () => _clearFilterSettings(clearCategories: true),
        ),
      );
    }
    if (filterSettings.voivodeship != null) {
      chips.add(
        SelectedFilterChip(
          label: filterSettings.simpleLocationString,
          onDeleteFunction: () => _clearFilterSettings(clearLocation: true),
        ),
      );
    }
    if (filterSettings.showActiveOnly != FilterSettings.DEFAULT_SHOW_ACTIVE_ONLY) {
      chips.add(
        SelectedFilterChip(
          label: 'Tylko Aktywne',
          onDeleteFunction: () => _clearFilterSettings(clearActiveOnly: true),
        ),
      );
    }
    if (filterSettings.ageTypes.isNotEmpty) {
      chips.add(
        SelectedFilterChip(
          label: filterSettings.ageTypesShortString,
          onDeleteFunction: () => _clearFilterSettings(clearAgeTypes: true),
        ),
      );
    }
    if (filterSettings.sortBy != FilterSettings.DEFAULT_SORTING_TYPE) {
      chips.add(
        SelectedFilterChip(
          label: filterSettings.sortingString,
          onDeleteFunction: () => _clearFilterSettings(clearSorting: true),
        ),
      );
    }
    return chips;
  }

  void _clearFilterSettings(
      {bool clearInternetOnly = false,
      bool clearActiveOnly = false,
      bool clearLocation = false,
      bool clearSorting = false,
      bool clearPhrase = false,
      bool clearCategories = false,
      bool clearAgeTypes = false}) {
    filterSettings.clear(
        clearInternetOnly: clearInternetOnly,
        clearActiveOnly: clearActiveOnly,
        clearLocation: clearLocation,
        clearSorting: clearSorting,
        clearPhrase: clearPhrase,
        clearCategories: clearCategories,
        clearAgeTypes: clearAgeTypes);
    updateFunction(filterSettings);
  }
}
