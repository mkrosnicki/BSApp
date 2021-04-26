import 'package:BSApp/models/filter_settings.dart';
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
      width: double.infinity,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: Wrap(
              direction: Axis.horizontal,
              runAlignment: WrapAlignment.spaceBetween,
              runSpacing: 4.0,
              spacing: 0.0,
              children: [
                if (searchModel.phrase != null)
                  _buildItem('Szukana fraza', searchModel.phrase),
                if (filterSettings.categories.isNotEmpty)
                  _buildItem('Kategoria', filterSettings.categoriesString),
                if (filterSettings.voivodeship != null)
                  _buildItem('Lokalizacja', filterSettings.locationString),
                if (filterSettings.ageTypes.isNotEmpty)
                  _buildItem('Wiek dziecka', filterSettings.ageTypesString),
                if (filterSettings.showActiveOnly !=
                    FilterSettings.DEFAULT_SHOW_ACTIVE_ONLY)
                  _buildItem('Tylko aktywne okazje', 'Tak'),
                if (filterSettings.showInternetOnly !=
                    FilterSettings.DEFAULT_SHOW_INTERNET_ONLY)
                  _buildItem('Tylko internetowe okazje', 'Tak'),
              ],
            ),
          ),
          Container(
            height: 24.0,
            margin: const EdgeInsets.only(top: 20.0, bottom: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SecondaryButton(
                  'Przestań obserwować',
                  () {
                    Provider.of<Searches>(context, listen: false)
                        .deleteSearch(searchModel.id);
                  },
                  fontSize: 11,
                ),
                PrimaryButton(
                  'Zobacz wyniki',
                  () => Navigator.of(context).pushNamed(
                    DealSearchResultScreen.routeName,
                    arguments: searchModel.toFilterSettings(),
                  ),
                  fontSize: 11,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildItem(String label, String value) {
    return value != null
        ? FractionallySizedBox(
            widthFactor: 0.5,
            child: Container(
              padding: EdgeInsets.all(4.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 11, color: Colors.black54)),
                  Text(
                    value,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black87, fontSize: 12),
                  ),
                ],
              ),
            ),
          )
        : Container();
  }
}
