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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Provider.of<Categories>(context, listen: false).fetchCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.error != null) {
              return Center(
                child: Text('An error occurred!'),
              );
            } else {
              return Consumer<Categories>(
                builder: (context, categoriesData, child) =>
                    ListView.builder(
                      itemBuilder: (context, index) =>
                          Text(categoriesData.categories[index].name),
                      itemCount: categoriesData.categories.length,
                    ),
              );
            }
          }
        },
      )
      ,
    );
  }
}
