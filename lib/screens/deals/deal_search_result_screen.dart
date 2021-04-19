import 'package:BSApp/models/filter_settings.dart';
import 'package:BSApp/providers/deals.dart';
import 'package:BSApp/providers/searches.dart';
import 'package:BSApp/screens/authentication/auth_screen_provider.dart';
import 'package:BSApp/screens/deals/filter_selection_screen.dart';
import 'package:BSApp/widgets/bars/app_bar_back_button.dart';
import 'package:BSApp/widgets/bars/app_bar_search_input.dart';
import 'package:BSApp/widgets/common/selected_filter_chip.dart';
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
        children: <Widget>[
          if (!filterSettings.areDefaults())
            SizedBox(
              height: 40,
              width: double.infinity,
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: _buildFilterChips(),
                ),
              ),
            ),
          Container(
            // color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
            child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Znalezione okazje',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                InkWell(
                  onTap: () => _showFilterSelectionDialog(context),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      'Edytuj filtry',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
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
                return Center(child: CircularProgressIndicator());
              } else {
                if (snapshot.error != null) {
                  return Center(
                    child: Text('An error occurred!'),
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
          label: 'Kategoria: ${filterSettings.lastCategoryString}',
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
          label: filterSettings.ageTypesString,
          onDeleteFunction: () => _clearFilterSettings(clearCategories: true),
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

  _initFilterSettings() {
    if (filterSettings == null) {
      var passedFilterSettings = ModalRoute.of(context).settings.arguments;
      filterSettings = passedFilterSettings != null
          ? passedFilterSettings
          : FilterSettings();
      _searchTextController.text = filterSettings.phrase;
    }
  }

  _createSearchBox(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      // color: Colors.white,
      child: Row(
        children: [
          AppBarSearchInput(
            onTapInputFunction: () {},
            onSubmitInputFunction: (_) {},
            searchInputController: _searchTextController,
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

  _saveSearch() {
    Provider.of<Searches>(context, listen: false)
        .saveSearch(filterSettings.toSaveSearchDto());
  }
}
