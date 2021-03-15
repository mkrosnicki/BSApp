import 'package:flutter/material.dart';

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
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.of(context).pop('testowy result');
          },
          child: Text('Categories selection'),
        ),
      ),
    );
  }
}
