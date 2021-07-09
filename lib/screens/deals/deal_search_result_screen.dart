import 'package:BSApp/models/filter_settings.dart';
import 'package:BSApp/providers/deals.dart';
import 'package:BSApp/services/last_searches_util_service.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/util/my_styling_provider.dart';
import 'package:BSApp/widgets/bars/app_bar_add_to_observed_searches_button.dart';
import 'package:BSApp/widgets/bars/app_bar_back_button.dart';
import 'package:BSApp/widgets/common/deals_not_found.dart';
import 'package:BSApp/widgets/common/loading_indicator.dart';
import 'package:BSApp/widgets/common/server_error_splash.dart';
import 'package:BSApp/widgets/deals/deal_item.dart';
import 'package:BSApp/widgets/deals/filters/filter_settings_bar.dart';
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
  final TextEditingController _searchTextController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 0;
  FilterSettings filterSettings;

  @override
  void initState() {
    _currentPage = 0;
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        final dealsProvider = Provider.of<Deals>(context, listen: false);
        if (dealsProvider.canLoadPage(_currentPage + 1)) {
          dealsProvider.fetchDealsPaged(pageNo: ++_currentPage, requestParams: filterSettings.toParamsMap());
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _initFilterSettings();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          titleSpacing: 0,
          title: _createSearchBox(context),
          leadingWidth: 40.0,
          automaticallyImplyLeading: false,
          leading: AppBarBackButton(
            Colors.white,
            function: () => Navigator.of(context).pop(true),
          ),
          backgroundColor: MyColorsProvider.PASTEL_BLUE,
          elevation: 0,
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FilterSettingsBar(filterSettings, _updateFilterSettings),
          FutureBuilder(
            future: Provider.of<Deals>(context, listen: false).fetchDealsPaged(
              requestParams: filterSettings.toParamsMap(),
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: LoadingIndicator());
              } else {
                if (snapshot.error != null) {
                  return const Expanded(
                    child: Center(
                      child: ServerErrorSplash(),
                    ),
                  );
                } else {
                  return Flexible(
                    child: Consumer<Deals>(
                      builder: (context, dealsData, child) {
                        if (dealsData.deals.isNotEmpty) {
                          return ListView.builder(
                            controller: _scrollController,
                            itemBuilder: (context, index) => DealItem(dealsData.deals[index]),
                            itemCount: dealsData.deals.length,
                          );
                        } else {
                          return const DealsNotFound();
                        }
                      },
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
                    color: Colors.black87,
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
        _currentPage = 0;
        filterSettings = newFilterSettings;
      });
      LastSearchesUtilService.saveFilterSettings(newFilterSettings);
    }
  }
}
