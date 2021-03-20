import 'package:BSApp/models/age_type.dart';
import 'package:BSApp/models/search_model.dart';
import 'package:BSApp/screens/deals/deal_search_result_screen.dart';
import 'package:flutter/material.dart';

class ObservedSearchItem extends StatelessWidget {
  final SearchModel searchModel;

  ObservedSearchItem(this.searchModel);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        searchModel.phrase != null ? Text(searchModel.phrase) : Container(),
        searchModel.sortBy != null
            ? Text(searchModel.sortBy.toString())
            : Container(),
        searchModel.voivodeship != null
            ? Text(searchModel.voivodeship.name)
            : Container(),
        searchModel.city != null ? Text(searchModel.city.name) : Container(),
        Text(searchModel.showInternetOnly.toString()),
        Text(searchModel.showActiveOnly.toString()),
        Text(AgeTypeHelper.asParamString(searchModel.ageTypes)),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacementNamed(DealSearchResultScreen.routeName, arguments: searchModel.toFilterSettings());
          },
          child: Text('Zobacz wyniki'),
        ),
        Divider()
      ],
    );
  }
}
