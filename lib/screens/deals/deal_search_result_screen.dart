import 'package:BSApp/models/filter_settings.dart';
import 'package:BSApp/providers/deals.dart';
import 'package:BSApp/services/last_searches_util_service.dart';
import 'package:BSApp/util/my_styling_provider.dart';
import 'package:BSApp/widgets/bars/app_bar_add_to_observed_searches_button.dart';
import 'package:BSApp/widgets/bars/app_bar_back_button.dart';
import 'package:BSApp/widgets/common/loading_indicator.dart';
import 'package:BSApp/widgets/common/server_error_splash.dart';
import 'package:BSApp/widgets/deals/deal_item.dart';
import 'package:BSApp/widgets/deals/filter_settings_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class DealSearchResultScreen extends StatefulWidget {
  static const routeName = '/deal-search';

  @override
  _DealSearchResultScreenState createState() => _DealSearchResultScreenState();
}

class _DealSearchResultScreenState extends State<DealSearchResultScreen> {
  FilterSettings filterSettings;

  final _searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _initFilterSettings();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          titleSpacing: 6,
          title: _createSearchBox(context),
          leadingWidth: 40.0,
          brightness: Brightness.light,
          backwardsCompatibility: false,
          systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.white),
          automaticallyImplyLeading: false,
          leading: const AppBarBackButton(Colors.black87),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FilterSettingsBar(filterSettings, _updateFilterSettings),
          FutureBuilder(
            future: Provider.of<Deals>(context, listen: false).fetchDeals(requestParams: filterSettings.toParamsMap()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: LoadingIndicator());
              } else {
                if (snapshot.error != null) {
                  return const Center(
                    child: ServerErrorSplash(),
                  );
                } else {
                  return Flexible(
                    child: Consumer<Deals>(
                      builder: (context, dealsData, child) => ListView.builder(
                        itemBuilder: (context, index) => DealItem(dealsData.deals[index]),
                        itemCount: dealsData.deals.length,
                      ),
                    ),
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }

  void _initFilterSettings() {
    if (filterSettings == null) {
      final passedFilterSettings = ModalRoute.of(context).settings.arguments as FilterSettings;
      filterSettings = passedFilterSettings ?? FilterSettings();
      _searchTextController.text = filterSettings.phrase;
      LastSearchesUtilService.saveFilterSettings(passedFilterSettings);
    }
  }

  Widget _createSearchBox(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      // color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchTextController,
              onSubmitted: (phrase) {
                filterSettings.phrase = phrase;
                _updateFilterSettings(filterSettings);
              },
              keyboardType: TextInputType.text,
              style: const TextStyle(fontSize: 12),
              decoration: MyStylingProvider.TEXT_FIELD_DECORATION.copyWith(
                hintText: 'Czego szukasz?',
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(0.0),
                  child: Icon(
                    CupertinoIcons.search,
                    color: Colors.black54,
                    size: 15,
                  ),
                ),
                prefixIconConstraints: BoxConstraints.tight(
                  const Size.square(30),
                ),
              ),
            ),
          ),
          AppBarAddToObservedSearchesButton(filterSettings),
        ],
      ),
    );
  }

  void _updateFilterSettings(FilterSettings newFilterSettings) {
    if (newFilterSettings != null) {
      setState(() {
        filterSettings = newFilterSettings;
      });
      if (filterSettings.phrase != null) {
        LastSearchesUtilService.saveFilterSettings(newFilterSettings);
      }
    }
  }
}
