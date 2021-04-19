import 'package:BSApp/models/filter_settings.dart';
import 'package:flutter/material.dart';

class LastSearchItem extends StatelessWidget {

  final FilterSettings filterSettings;

  LastSearchItem(this.filterSettings);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: Text('Wyszukiwanie numer ${filterSettings}'),
    );
  }
}
