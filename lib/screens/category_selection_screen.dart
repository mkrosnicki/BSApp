import 'package:BSApp/models/category_model.dart';
import 'package:BSApp/providers/categories.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategorySelectionScreen extends StatefulWidget {
  static const routeName = '/category-selection';

  @override
  _CategorySelectionScreenState createState() =>
      _CategorySelectionScreenState();
}

class _CategorySelectionScreenState extends State<CategorySelectionScreen> {
  List<CategoryModel> _allCategories;
  List<CategoryModel> _selectedCategories = [];

  Future<void> _initCategories() {
    if (_allCategories == null) {
      return Provider.of<Categories>(context, listen: false).fetchCategories().then((_) {
        _allCategories = Provider.of<Categories>(context, listen: false).categories;
      });
    } else {
      return Future(() => {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _selectedCategories.isEmpty
          ? FutureBuilder(
              future: _initCategories(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  if (snapshot.error != null) {
                    return Center(
                      child: Text('An error occurred!'),
                    );
                  } else {
                    return _buildCategoriesList(_allCategories);
                  }
                }
              },
            )
          : _buildCategoriesList(_selectedCategories.elementAt(_selectedCategories.length - 1).subCategories),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: Text('Wybierz kategorię'),
      automaticallyImplyLeading: false,
      leading: FlatButton(
        onPressed: () => _goUp(),
        child: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
      actions: [
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop(null);
          },
          child: Icon(
            Icons.clear,
            color: Colors.white,
          ),
        )
      ],
    );
  }

  _buildCategoriesList(List<CategoryModel> categories) {
    return Column(
      children: [
        if (_selectedCategories.isNotEmpty) ListTile(
          title: Text('${_selectedCategories.elementAt(_selectedCategories.length - 1).name}'),
          focusColor: Colors.grey,
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) => FlatButton(
              child: ListTile(
                title: Text(categories[index].name),
                subtitle: Text('${categories[index].subCategories.length} pod${_getCategoriesSuffix(categories[index].subCategories.length)}'),
                trailing: categories[index].subCategories.isEmpty ? Icon(null) : Icon(Icons.chevron_right),
                focusColor: Colors.grey,
              ),
              onPressed: () => _selectCategory(categories[index]),
            ),
            itemCount: categories.length,
          ),
        ),
      ],
    );
  }

  String _getCategoriesSuffix(int numOfCategories) {
    int lastDigit = numOfCategories % 10;
    if (numOfCategories == 1) {
      return 'kategoria';
    } else if (numOfCategories >= 11 && numOfCategories <= 14) {
      return 'kategorii';
    } else if (lastDigit == 2 || lastDigit == 3 || lastDigit == 4) {
      return 'kategorie';
    } else {
      return 'kategorii';
    }
  }

  _selectCategory(CategoryModel category) {
    if (category.subCategories.isEmpty) {
      Navigator.of(context).pop(category);
    } else {
      setState(() {
        _selectedCategories.add(category);
      });
    }
  }

  _goUp() {
    if (_selectedCategories.isEmpty) {
      Navigator.of(context).pop(null);
    } else {
      setState(() {
        _selectedCategories.removeLast();
      });
    }
  }
}
