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
  CategoryModel _selectedCategory;

  Future<void> _initCategories() {
    return Provider.of<Categories>(context, listen: false).fetchCategories().then((_) {
      _allCategories = Provider.of<Categories>(context, listen: false).categories;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _selectedCategory == null
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
          : _buildCategoriesList(_selectedCategory.subCategories),
    );
  }

  _buildCategoriesList(List<CategoryModel> categories) {
    return ListView.builder(
      itemBuilder: (context, index) => FlatButton(
        child: ListTile(
          title: Text(categories[index].name),
          subtitle: Text('${categories[index].subCategories.length}'),
          trailing: Icon(Icons.chevron_right),
          focusColor: Colors.grey,
        ),
        onPressed: () =>
            _selectCategory(categories[index]),
      ),
      itemCount: categories.length,
    );
  }

  _selectCategory(CategoryModel category) {
    if (category.subCategories.isEmpty) {
      Navigator.of(context).pop(category);
    } else {
      setState(() {
        _selectedCategory = category;
      });
    }
  }
}
