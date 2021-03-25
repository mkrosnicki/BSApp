import 'package:BSApp/widgets/bars/my_navigation_bar.dart';
import 'package:flutter/material.dart';

class AddDealScreen extends StatefulWidget {
  static const routeName = '/add-deal';

  @override
  _AddDealScreenState createState() => _AddDealScreenState();
}

class _AddDealScreenState extends State<AddDealScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dodaj nowe znalezisko!'),
      ),
      body: Text('text'),
      bottomNavigationBar: MyNavigationBar(2),
    );
  }
}
