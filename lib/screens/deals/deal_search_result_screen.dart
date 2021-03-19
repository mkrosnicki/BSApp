import 'package:BSApp/models/filter_settings.dart';
import 'package:BSApp/providers/deals.dart';
import 'package:BSApp/providers/searches.dart';
import 'package:BSApp/screens/deals/filter_selection_screen.dart';
import 'package:BSApp/widgets/bars/app_bar_search_input.dart';
import 'package:BSApp/widgets/bars/my_navigation_bar.dart';
import 'package:BSApp/widgets/deals/deal_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DealSearchResultScreen extends StatefulWidget {
  static const routeName = '/deal-search';

  @override
  _DealSearchResultScreenState createState() => _DealSearchResultScreenState();
}

class _DealSearchResultScreenState extends State<DealSearchResultScreen> {
  FilterSettings filterSettings = FilterSettings();

  final _searchTextController = TextEditingController();

  _createSearchBox(BuildContext context) {
    _searchTextController.text =
        ModalRoute.of(context).settings.arguments as String;
    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      // color: Colors.white,
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.arrow_back),
            ),
          ),
          AppBarSearchInput(
            onTapInputFunction: () {},
            onSubmitInputFunction: (_) {},
            searchInputController: _searchTextController,
          ),
          GestureDetector(
            onTap: () {
              Provider.of<Searches>(context, listen: false)
                  .saveSearch(filterSettings.toSaveSearchDto());
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Icon(Icons.favorite_border),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          titleSpacing: 8,
          title: _createSearchBox(context),
          automaticallyImplyLeading: false,
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 50,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: _buildFilterChips(),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Znalezione okazje',
                    style: TextStyle(fontSize: 18),
                  ),
                  InkWell(
                    onTap: () => _showFilterSelectionDialog(context),
                    customBorder: CircleBorder(),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(Icons.filter_list),
                    ),
                  )
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
                        builder: (context, dealsData, child) =>
                            ListView.builder(
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
        bottomNavigationBar: MyNavigationBar(0));
  }

  Future _showFilterSelectionDialog(BuildContext context) async {
    var newFilterSettings =
        await Navigator.of(context).push(new MaterialPageRoute<FilterSettings>(
            builder: (BuildContext context) {
              return FilterSelectionScreen();
            },
            settings: RouteSettings(arguments: filterSettings),
            fullscreenDialog: true));
    setState(() {
      filterSettings = newFilterSettings;
    });
  }

  _buildFilterChips() {
    List<Widget> chips = [];
    if (filterSettings.showInternetOnly !=
        FilterSettings.DEFAULT_SHOW_INTERNET_ONLY) {
      chips.add(InputChip(
        label: Text('Internetowe'),
        deleteIcon: Icon(Icons.cancel_outlined),
        onDeleted: () => _clearFilterSettings(clearInternetOnly: true),
      ));
    }
    if (filterSettings.categories.isNotEmpty) {
      chips.add(InputChip(
        label: Text('Kategorie'),
        deleteIcon: Icon(Icons.cancel_outlined),
        onDeleted: () => _clearFilterSettings(clearCategories: true),
      ));
    }
    if (filterSettings.voivodeship != null) {
      chips.add(InputChip(
        label: Text('Lokalizacja'),
        deleteIcon: Icon(Icons.cancel_outlined),
        onDeleted: () => _clearFilterSettings(clearSorting: true),
      ));
    }
    if (filterSettings.showActiveOnly !=
        FilterSettings.DEFAULT_SHOW_ACTIVE_ONLY) {
      chips.add(InputChip(
        label: Text('Aktywne'),
        deleteIcon: Icon(Icons.cancel_outlined),
        onDeleted: () => _clearFilterSettings(clearActiveOnly: true),
      ));
    }
    if (filterSettings.ageTypes.isNotEmpty) {
      chips.add(InputChip(
        label: Text('Wiek dziecka'),
        deleteIcon: Icon(Icons.cancel_outlined),
        onDeleted: () => _clearFilterSettings(clearCategories: true),
      ));
    }
    if (filterSettings.sortBy != FilterSettings.DEFAULT_SORTING_TYPE) {
      chips.add(InputChip(
        label: Text('Sortowanie'),
        deleteIcon: Icon(Icons.cancel_outlined),
        onDeleted: () => _clearFilterSettings(clearActiveOnly: true),
      ));
    }
    return chips;
  }

  _clearFilterSettings(
      {bool clearInternetOnly,
      bool clearActiveOnly,
      bool clearLocation,
      bool clearSorting,
      bool clearPhrase,
      bool clearCategories,
      bool clearAgeTypes}) {
    setState(() {
      if (clearInternetOnly) {
        filterSettings.clearInternetOnly();
      }
      if (clearActiveOnly) {
        filterSettings.clearActiveOnly();
      }
      if (clearLocation) {
        filterSettings.clearLocation();
      }
      if (clearSorting) {
        filterSettings.clearSorting();
      }
      if (clearPhrase) {
        filterSettings.clearPhrase();
      }
      if (clearCategories) {
        filterSettings.clearCategories();
      }
      if (clearAgeTypes) {
        filterSettings.clearAgeTypes();
      }
    });
  }
}
