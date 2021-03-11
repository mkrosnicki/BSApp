import 'package:BSApp/widgets/profile_option_item.dart';
import 'package:flutter/material.dart';

class ProfileOptionsList extends StatelessWidget {
  List<Widget> menuOptions = [
    _buildSectionTitle('Pierwsza sekcja'),
    ProfileOptionItem('title1', '/favourites'),
    ProfileOptionItem('title1', '/favourites'),
    ProfileOptionItem('title1', '/favourites'),
    _buildSectionTitle('Druga sekcja'),
    ProfileOptionItem('title1', '/favourites'),
    ProfileOptionItem('title1', '/favourites'),
    ProfileOptionItem('title1', '/favourites'),
    ProfileOptionItem('title1', '/favourites'),
  ];

  static Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        itemBuilder: (context, index) => menuOptions[index],
        itemCount: menuOptions.length,
      ),
    );
  }
}
