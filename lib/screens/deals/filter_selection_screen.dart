import 'package:BSApp/models/filter_settings.dart';
import 'package:BSApp/screens/common/category_selection_screen.dart';
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
                    subtitle: filtersSettings.categories != null ? Text(filtersSettings.categoriesString, style: TextStyle(color: Colors.blue),) : null,
                    trailing: Icon(Icons.chevron_right),
                    onTap: () => _openCategorySelector(context) ,
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
    var selectedCategories = await Navigator.of(context).pushNamed(CategorySelectionScreen.routeName);
    // print(selectedCategory);
    setState(() {
      filtersSettings.categories = selectedCategories;
    });
  }

  _acceptFilters(BuildContext context) {
    Navigator.pop(context, 'jakas wartosc');
  }
}
