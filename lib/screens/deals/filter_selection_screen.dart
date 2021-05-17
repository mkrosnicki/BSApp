import 'package:BSApp/models/age_type.dart';
import 'package:BSApp/models/filter_settings.dart';
import 'package:BSApp/models/sorting_type.dart';
import 'package:BSApp/screens/common/category_selection_screen.dart';
import 'package:BSApp/screens/common/location_selection_screen.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/util/my_icons_provider.dart';
import 'package:BSApp/util/my_styling_provider.dart';
import 'package:BSApp/widgets/bars/app_bar_close_button.dart';
import 'package:BSApp/widgets/bars/base_app_bar.dart';
import 'package:BSApp/widgets/common/primary_button.dart';
import 'package:BSApp/widgets/filters/age_type_chip.dart';
import 'package:BSApp/widgets/filters/sorting_type_chip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilterSelectionScreen extends StatefulWidget {
  @override
  _FilterSelectionScreenState createState() => _FilterSelectionScreenState();
}

class _FilterSelectionScreenState extends State<FilterSelectionScreen> {
  static const TextStyle headerTextStyle = const TextStyle(fontSize: 14);
  static const TextStyle noValueTextStyle = const TextStyle(fontSize: 13);
  static const TextStyle valueTextStyle = const TextStyle(fontSize: 13, color: MyColorsProvider.DEEP_BLUE);

  FilterSettings filtersSettings;

  _initFilterSettings(BuildContext context) {
    if (filtersSettings == null) {
      FilterSettings passedFilterSettings =
          ModalRoute.of(context).settings.arguments as FilterSettings;
      filtersSettings = passedFilterSettings != null
          ? passedFilterSettings
          : FilterSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    _initFilterSettings(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BaseAppBar(
        title: 'Filtry i sortowanie',
        leading: const AppBarCloseButton(Colors.black),
        actions: [
          TextButton(
            onPressed: _clearFilters,
            child: const Text(
              'Wyczyść',
              style: TextStyle(color: MyColorsProvider.BLUE),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SwitchListTile(
                      title: const Text('Pokaż tylko aktywne',
                          style: headerTextStyle),
                      value: filtersSettings.showActiveOnly,
                      onChanged: (value) {
                        setState(() {
                          filtersSettings.showActiveOnly = value;
                        });
                      },
                    ),
                    ListTile(
                      title: const Text('Kategoria', style: headerTextStyle),
                      subtitle: filtersSettings.categories.isNotEmpty
                          ? Text(
                              filtersSettings.categoriesString,
                              style: valueTextStyle,
                            )
                          : const Text('Wszystkie kategorie', style: noValueTextStyle,),
                      trailing: MyIconsProvider.FORWARD_ICON,
                      onTap: () => _openCategorySelector(context),
                    ),
                    SwitchListTile(
                      title: const Text('Tylko internetowe okazje',
                          style: headerTextStyle),
                      value: filtersSettings.showInternetOnly,
                      onChanged: (value) {
                        setState(() {
                          filtersSettings.showInternetOnly = value;
                          filtersSettings.voivodeship = null;
                          filtersSettings.city = null;
                        });
                      },
                    ),
                    ListTile(
                      title: const Text('Lokalizacja', style: headerTextStyle),
                      subtitle: filtersSettings.voivodeship != null
                          ? Text(
                              filtersSettings.locationString,
                              style: valueTextStyle,
                            )
                          : const Text(
                              'Cała Polska',
                              style: noValueTextStyle,
                            ),
                      trailing: MyIconsProvider.FORWARD_ICON,
                      onTap: () => _openLocationSelector(context),
                      enabled: !filtersSettings.showInternetOnly,
                    ),
                    ListTile(
                      title: const Text('Wiek dziecka', style: headerTextStyle),
                      subtitle: filtersSettings.ageTypes.isEmpty
                          ? const Text('Dowolny', style: noValueTextStyle)
                          : Text(
                              filtersSettings.ageTypesString,
                              overflow: TextOverflow.ellipsis,
                              style: valueTextStyle,
                            ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        children: _buildAgeTypeChips(),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: const Text('Sortuj po', style: headerTextStyle),
                    ),
                    Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Flex(
                        direction: Axis.horizontal,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _buildSortingTypeChips(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 10,
              margin: EdgeInsets.zero,
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                child: PrimaryButton(
                  'Pokaż wyniki',
                  () => _acceptFilters(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildAgeTypeChips() {
    final List<Widget> list = [];
    AgeType.values.forEach(
      (e) => list.add(
        AgeTypeChip(
          e,
          filtersSettings.ageTypes.contains(e),
          () {
            setState(() {
              if (!filtersSettings.ageTypes.contains(e)) {
                filtersSettings.ageTypes.add(e);
              } else {
                filtersSettings.ageTypes.remove(e);
              }
            });
          },
        ),
      ),
    );
    return list;
  }

  List<Widget> _buildSortingTypeChips() {
    List<Widget> list = [
      SortingTypeChip(
        SortingType.NEWEST,
        filtersSettings.sortBy == SortingType.NEWEST,
        () {
          setState(() {
            filtersSettings.sortBy = SortingType.NEWEST;
          });
        },
      ),
      SortingTypeChip(
        SortingType.MOST_POPULAR,
        filtersSettings.sortBy == SortingType.MOST_POPULAR,
        () {
          setState(() {
            filtersSettings.sortBy = SortingType.MOST_POPULAR;
          });
        },
      ),
    ];
    return list;
  }

  _openCategorySelector(BuildContext context) async {
    final selectedCategories = await Navigator.of(context)
        .pushNamed(CategorySelectionScreen.routeName);
    if (selectedCategories != null) {
      setState(() {
        filtersSettings.categories = selectedCategories;
      });
    }
  }

  _openLocationSelector(BuildContext context) async {
    var locations = await Navigator.of(context)
        .pushNamed(LocationSelectionScreen.routeName);
    if (locations != null) {
      setState(() {
        filtersSettings.voivodeship = (locations as List)[0];
        filtersSettings.city = (locations as List)[1];
      });
    }
  }

  _clearFilters() {
    setState(() {
      filtersSettings.clearAll();
    });
  }

  _acceptFilters(BuildContext context) {
    Navigator.pop(context, filtersSettings);
  }
}
