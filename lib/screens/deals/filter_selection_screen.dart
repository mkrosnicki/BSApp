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

  FilterSettings filtersSettings = FilterSettings();

  @override
  Widget build(BuildContext context) {
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
            child: Text('Wyczyść', style: TextStyle(color: Colors.white),),
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
                    title: Text('Pokaż tylko aktywne'),
                    value: filtersSettings.showActiveOnly,
                    onChanged: (value) {
                      setState(() {
                        filtersSettings.showActiveOnly = value;
                      });
                    },
                  ),
                  ListTile(
                    title: Text('Kategoria'),
                    subtitle: filtersSettings.categories.isNotEmpty
                        ? Text(
                            filtersSettings.categoriesString,
                            style: TextStyle(color: Colors.blue),
                          )
                        : const Text('Wszystkie kategorie'),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () => _openCategorySelector(context),
                  ),
                  SwitchListTile(
                    title: Text('Tylko internetowe okazje'),
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
                    title: Text('Lokalizacja'),
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
                    title: Text('Wiek dziecka'),
                    subtitle: filtersSettings.ageTypes.isEmpty
                        ? Text('Dowolny')
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
                    title: Text('Sortuj po'),
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
                child: Text('Filtruj'),
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
          label: Text(AgeTypeHelper.getString(e)),
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
              label: Text(SortingTypeHelper.getString(e)),
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
    setState(() {
      filtersSettings.categories = selectedCategories;
    });
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

  _acceptFilters(BuildContext context) {
    Navigator.pop(context, filtersSettings);
  }
}
