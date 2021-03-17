import 'package:BSApp/models/filter_settings.dart';
import 'package:BSApp/screens/common/category_selection_screen.dart';
import 'package:BSApp/screens/common/location_selection_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilterSelectionScreen extends StatefulWidget {
  @override
  _FilterSelectionScreenState createState() => _FilterSelectionScreenState();
}

class _FilterSelectionScreenState extends State<FilterSelectionScreen> {
  Map<String, dynamic> filtersMap = {
    'category': null,
    'phrase': '',
  };
  final FilterSettings filtersSettings = FilterSettings();

  FocusNode _optionAFocusNode = FocusNode();

  var isSelected = [true, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filtry i sortowanie'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Kategoria'),
                  ListTile(
                    title: Text('Kategoria'),
                    subtitle: filtersSettings.categories != null
                        ? Text(
                            filtersSettings.categoriesString,
                            style: TextStyle(color: Colors.blue),
                          )
                        : null,
                    trailing: Icon(Icons.chevron_right),
                    onTap: () => _openCategorySelector(context),
                  ),
                  SwitchListTile(
                    title: Text('Pokaż tylko aktywne'),
                    value: filtersSettings.showActiveOnly,
                    onChanged: (value) {
                      setState(() {
                        filtersSettings.showActiveOnly = value;
                      });
                    },
                  ),
                  SwitchListTile(
                    title: Text('Tylko internetowe okazje'),
                    value: filtersSettings.showActiveOnly,
                    onChanged: (value) {
                      setState(() {
                        filtersSettings.showActiveOnly = value;
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
                        : null,
                    trailing: Icon(Icons.chevron_right),
                    onTap: () => _openLocationSelector(context),
                  ),
                  Container(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          flex: 1,
                          child: ListTile(
                            title: Text('title1'),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: ListTile(
                            title: Text('title1'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: ToggleButtons(
                      onPressed: (int index) {
                        setState(() {
                          for (int buttonIndex = 0;
                              buttonIndex < isSelected.length;
                              buttonIndex++) {
                            if (buttonIndex == index) {
                              isSelected[buttonIndex] = true;
                            } else {
                              isSelected[buttonIndex] = false;
                            }
                          }
                        });
                      },
                      isSelected: isSelected,
                      children: [
                        Text('Opcja A'),
                        Text('Opcja B'),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Text('title1'),
                  ),
                  ListTile(
                    title: Text('title1'),
                  ),
                  ListTile(
                    title: Text('title1'),
                  ),
                  ListTile(
                    title: Text('title1'),
                  ),
                  ListTile(
                    title: Text('title1'),
                  ),
                  ListTile(
                    title: Text('title1'),
                  ),
                  ListTile(
                    title: Text('title1'),
                  ),
                  ListTile(
                    title: Text('title1'),
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
    Navigator.pop(context, 'jakas wartosc');
  }
}
