import 'package:BSApp/models/age_type.dart';
import 'package:BSApp/models/filter_settings.dart';
import 'package:BSApp/models/sorting_type.dart';
import 'package:BSApp/screens/common/category_selection_screen.dart';
import 'package:BSApp/screens/common/location_selection_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilterSelectionScreen extends StatefulWidget {
  @override
  _FilterSelectionScreenState createState() => _FilterSelectionScreenState();
}

class _FilterSelectionScreenState extends State<FilterSelectionScreen> {
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
      appBar: AppBar(
        title: Text('Filtry i sortowanie'),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                filtersSettings = FilterSettings();
              });
            },
            child: TextButton(
              onPressed: _clearFilters,
              child: Text(
                'Wyczyść',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SwitchListTile(
                    title: const Text('Pokaż tylko aktywne'),
                    value: filtersSettings.showActiveOnly,
                    onChanged: (value) {
                      setState(() {
                        filtersSettings.showActiveOnly = value;
                      });
                    },
                  ),
                  ListTile(
                    title: const Text('Kategoria'),
                    subtitle: filtersSettings.categories.isNotEmpty
                        ? Text(
                            filtersSettings.categoriesString,
                            style: TextStyle(color: Colors.blue),
                          )
                        : const Text('Wszystkie kategorie'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => _openCategorySelector(context),
                  ),
                  SwitchListTile(
                    title: const Text('Tylko internetowe okazje'),
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
                    title: const Text('Lokalizacja'),
                    subtitle: filtersSettings.voivodeship != null
                        ? Text(
                            filtersSettings.locationString,
                            style: TextStyle(color: Colors.blue),
                          )
                        : const Text('Cała Polska'),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () => _openLocationSelector(context),
                    enabled: !filtersSettings.showInternetOnly,
                  ),
                  ListTile(
                    title: const Text('Wiek dziecka'),
                    subtitle: filtersSettings.ageTypes.isEmpty
                        ? const Text('Dowolny')
                        : Text(
                            filtersSettings.ageTypesString,
                            overflow: TextOverflow.ellipsis,
                          ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Wrap(
                      alignment: WrapAlignment.spaceEvenly,
                      children: _buildAgeTypeChips(),
                    ),
                  ),
                  ListTile(
                    title: const Text('Sortuj po'),
                  ),
                  Container(
                    width: double.infinity,
                    child: Wrap(
                      alignment: WrapAlignment.center,
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
              child: RaisedButton(
                child: const Text('Filtruj'),
                onPressed: () => _acceptFilters(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildAgeTypeChips() {
    List<Widget> list = [];
    AgeType.values.forEach(
      (e) => list.add(Container(
        margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
        child: ChoiceChip(
          label: Text(AgeTypeHelper.getReadable(e)),
          selected: filtersSettings.ageTypes.contains(e),
          onSelected: (isSelected) {
            setState(() {
              if (isSelected) {
                filtersSettings.ageTypes.add(e);
              } else {
                filtersSettings.ageTypes.remove(e);
              }
            });
          },
        ),
      )),
    );
    return list;
  }

  _buildSortingTypeChips() {
    List<Widget> list = SortingType.values
        .map(
          (e) => Container(
            margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
            child: ChoiceChip(
              label: Text(SortingTypeHelper.getReadable(e)),
              selected: filtersSettings.sortBy == e,
              onSelected: (isSelected) {
                setState(() {
                  filtersSettings.sortBy = e;
                });
              },
            ),
          ),
        )
        .toList();
    return list;
  }

  _openCategorySelector(BuildContext context) async {
    var selectedCategories = await Navigator.of(context)
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
