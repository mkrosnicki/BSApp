import 'package:BSApp/models/filter_settings.dart';
import 'package:BSApp/providers/deals.dart';
import 'package:BSApp/providers/searches.dart';
import 'package:BSApp/screens/authentication/auth_screen_provider.dart';
import 'package:BSApp/screens/deals/filter_selection_screen.dart';
import 'package:BSApp/services/last_searches_util_service.dart';
import 'package:BSApp/util/my_styling_provider.dart';
import 'package:BSApp/widgets/bars/app_bar_back_button.dart';
import 'package:BSApp/widgets/common/loading_indicator.dart';
import 'package:BSApp/widgets/common/selected_filter_chip.dart';
import 'package:BSApp/widgets/common/server_error_splash.dart';
import 'package:BSApp/widgets/deals/deal_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          titleSpacing: 6,
          title: _createSearchBox(context),
          leadingWidth: 40.0,
          automaticallyImplyLeading: false,
          leading: AppBarBackButton(Colors.black87),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (!filterSettings.areDefaults())
            Container(
              color: Colors.white,
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                // direction: Axis.vertical,
                alignment: WrapAlignment.start,
                children: _buildFilterChips(),
              ),
            ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(
                top: 4.0, bottom: 4.0, left: 12.0, right: 2.0),
            child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Znalezione okazje',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600),
                ),
                InkWell(
                  onTap: () => _showFilterSelectionDialog(context),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                    child: Icon(
                      CupertinoIcons.slider_horizontal_3,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
          FutureBuilder(
            future: Provider.of<Deals>(context, listen: false)
                .fetchDeals(requestParams: filterSettings.toParamsMap()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: const LoadingIndicator());
              } else {
                if (snapshot.error != null) {
                  return Center(
                    child: const ServerErrorSplash(),
                  );
                } else {
                  return Flexible(
                    child: Consumer<Deals>(
                      builder: (context, dealsData, child) => ListView.builder(
                        itemBuilder: (context, index) =>
                            DealItem(dealsData.deals[index]),
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

  _initFilterSettings() {
    if (filterSettings == null) {
      var passedFilterSettings =
          ModalRoute.of(context).settings.arguments as FilterSettings;
      filterSettings = passedFilterSettings != null
          ? passedFilterSettings
          : FilterSettings();
      _searchTextController.text = filterSettings.phrase;
      LastSearchesUtilService.saveFilterSettings(passedFilterSettings);
    }
  }

  _createSearchBox(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      // color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchTextController,
              onSubmitted: (phrase) {}, // todo
              keyboardType: TextInputType.text,
              style: const TextStyle(fontSize: 12),
              decoration:
              MyStylingProvider.TEXT_FIELD_DECORATION.copyWith(
                hintText: 'Czego szukasz?',
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(0.0),
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
          Consumer<Searches>(
            builder: (context, searchesData, child) => GestureDetector(
              onTap: () {
                if (searchesData.token == null) {
                  AuthScreenProvider.showLoginScreen(context);
                } else {
                  _saveSearch();
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: searchesData.isSaved(filterSettings)
                    ? Icon(CupertinoIcons.heart_fill, color: Colors.black87)
                    : Icon(CupertinoIcons.heart, color: Colors.black87),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future _showFilterSelectionDialog(BuildContext context) async {
    var newFilterSettings =
        await Navigator.of(context).push(new MaterialPageRoute<FilterSettings>(
            builder: (BuildContext context) {
              return FilterSelectionScreen();
            },
            settings: RouteSettings(arguments: filterSettings),
            fullscreenDialog: true));
    if (newFilterSettings != null) {
      setState(() {
        filterSettings = newFilterSettings;
      });
      if (filterSettings.phrase != null) {
        LastSearchesUtilService.saveFilterSettings(newFilterSettings);
      }
    }
  }

  _buildFilterChips() {
    List<Widget> chips = [];
    if (filterSettings.showInternetOnly !=
        FilterSettings.DEFAULT_SHOW_INTERNET_ONLY) {
      chips.add(
        SelectedFilterChip(
          label: 'Tylko Internetowe',
          onDeleteFunction: () => _clearFilterSettings(clearInternetOnly: true),
        ),
      );
    }
    if (filterSettings.categories.isNotEmpty) {
      chips.add(
        SelectedFilterChip(
          label: filterSettings.lastCategoryString,
          onDeleteFunction: () => _clearFilterSettings(clearCategories: true),
        ),
      );
    }
    if (filterSettings.voivodeship != null) {
      chips.add(
        SelectedFilterChip(
          label: filterSettings.simpleLocationString,
          onDeleteFunction: () => _clearFilterSettings(clearSorting: true),
        ),
      );
    }
    if (filterSettings.showActiveOnly !=
        FilterSettings.DEFAULT_SHOW_ACTIVE_ONLY) {
      chips.add(
        SelectedFilterChip(
          label: 'Tylko Aktywne',
          onDeleteFunction: () => _clearFilterSettings(clearActiveOnly: true),
        ),
      );
    }
    if (filterSettings.ageTypes.isNotEmpty) {
      chips.add(
        SelectedFilterChip(
          label: filterSettings.ageTypesShortString,
          onDeleteFunction: () => _clearFilterSettings(clearAgeTypes: true),
        ),
      );
    }
    if (filterSettings.sortBy != FilterSettings.DEFAULT_SORTING_TYPE) {
      chips.add(
        SelectedFilterChip(
          label: filterSettings.sortingString,
          onDeleteFunction: () => _clearFilterSettings(clearActiveOnly: true),
        ),
      );
    }
    return chips;
  }

  _clearFilterSettings(
      {bool clearInternetOnly = false,
      bool clearActiveOnly = false,
      bool clearLocation = false,
      bool clearSorting = false,
      bool clearPhrase = false,
      bool clearCategories = false,
      bool clearAgeTypes = false}) {
    setState(() {
      filterSettings.clear(
          clearInternetOnly: false,
          clearActiveOnly: clearActiveOnly,
          clearLocation: clearLocation,
          clearSorting: clearSorting,
          clearPhrase: clearPhrase,
          clearCategories: clearCategories,
          clearAgeTypes: clearAgeTypes);
    });
  }

  _saveSearch() {
    Provider.of<Searches>(context, listen: false)
        .saveSearch(filterSettings.toSaveSearchDto());
  }
}
