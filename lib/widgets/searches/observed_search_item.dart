import 'package:BSApp/models/search_model.dart';
import 'package:BSApp/providers/searches.dart';
import 'package:BSApp/screens/deals/deal_search_result_screen.dart';
import 'package:BSApp/widgets/common/primary-button.dart';
import 'package:BSApp/widgets/common/secondary-button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ObservedSearchItem extends StatelessWidget {
  final SearchModel searchModel;

  ObservedSearchItem(this.searchModel);

  @override
  Widget build(BuildContext context) {
    var filterSettings = searchModel.toFilterSettings();
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildItem('Szukana fraza', searchModel.phrase),
          _buildItem('Kategoria', filterSettings.categoriesString),
          _buildItem('Lokalizacja', filterSettings.locationString),
          _buildItem('Wiek dziecka', filterSettings.ageTypesString),
          _buildItem('Tylko internetowe okazje',
              filterSettings.showInternetOnly.toString()),
          _buildItem(
              'Tylko aktywne okazje', filterSettings.showActiveOnly.toString()),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SecondaryButton(
                'Przestań obserwować',
                () {
                  Provider.of<Searches>(context, listen: false)
                      .deleteSearch(searchModel.id);
                },
                fontSize: 12,
              ),
              PrimaryButton(
                'Zobacz wyniki',
                () => Navigator.of(context).pushNamed(
                  DealSearchResultScreen.routeName,
                  arguments: searchModel.toFilterSettings(),
                ),
                fontSize: 12,
              )
            ],
          ),
        ],
      ),
    );
  }

  _buildItem(String label, String value) {
    return value != null
        ? Container(
            padding: EdgeInsets.all(4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: TextStyle(fontSize: 12, color: Colors.black87)),
                Text(
                  value,
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            ),
          )
        : Container();
  }
}
