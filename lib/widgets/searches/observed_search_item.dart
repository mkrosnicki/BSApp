import 'package:BSApp/models/filter_settings.dart';
import 'package:BSApp/models/search_model.dart';
import 'package:BSApp/providers/searches.dart';
import 'package:BSApp/screens/deals/deal_search_result_screen.dart';
import 'package:BSApp/widgets/common/primary_button.dart';
import 'package:BSApp/widgets/common/secondary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ObservedSearchItem extends StatelessWidget {
  final SearchModel searchModel;

  const ObservedSearchItem(this.searchModel);

  @override
  Widget build(BuildContext context) {
    final filterSettings = searchModel.toFilterSettings();
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      width: double.infinity,
      child: Column(
        children: [
          // ignore: sized_box_for_whitespace
          Container(
            width: double.infinity,
            child: Wrap(
              runAlignment: WrapAlignment.spaceBetween,
              runSpacing: 4.0,
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

  Widget _buildItem(String label, String value) {
    return value != null
        ? FractionallySizedBox(
            widthFactor: 0.5,
            child: Container(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 11, color: Colors.black54)),
                  Text(
                    value,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.black87, fontSize: 12),
                  ),
                ],
              ),
            ),
          )
        : Container();
  }
}
