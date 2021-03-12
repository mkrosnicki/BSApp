import 'package:BSApp/providers/deals.dart';
import 'package:BSApp/widgets/app_bar_search_input.dart';
import 'package:BSApp/widgets/deal_item.dart';
import 'package:BSApp/widgets/my_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DealSearchResultScreen extends StatelessWidget {
  static const routeName = '/deal-search';

  final _searchTextController = TextEditingController();

  _createSearchBox(BuildContext context) {
    _searchTextController.text = ModalRoute
        .of(context)
        .settings
        .arguments as String;
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
            onTap: () {},
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
            Text(
              'Headline',
              style: TextStyle(fontSize: 18),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 15,
                itemBuilder: (BuildContext context, int index) =>
                    Card(
                      child: Center(child: Text('Dummy Card Text')),
                    ),
              ),
            ),
            Text(
              'Znalezione promocje',
              style: TextStyle(fontSize: 18),
            ),
            Expanded(
              child: Consumer<Deals>(
                builder: (context, dealsData, child) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (ctx, int) {
                      return ListView.builder(
                        itemBuilder: (context, index) =>
                            DealItem(dealsData.deals[index]),
                        itemCount: dealsData.deals.length,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: MyNavigationBar(0));
  }
}
