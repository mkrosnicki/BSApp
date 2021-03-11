import 'package:BSApp/widgets/my_navigation_bar.dart';
import 'package:BSApp/widgets/profile_option_item.dart';
import 'package:flutter/material.dart';

class FavouritesScreen extends StatelessWidget {
  static const routeName = '/favourites';

  @override
  Widget build(BuildContext context) {
    List<String> widgets =
        List.generate(10, (index) => 'Option number $index');
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) => ProfileOptionItem(widgets[index], widgets[index]),
        itemCount: 10,
      ),
      bottomNavigationBar: MyNavigationBar(2),
    );
  }
}
