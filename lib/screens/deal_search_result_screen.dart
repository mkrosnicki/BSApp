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
            SizedBox(
              height: 50,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 15,
                  itemBuilder: (BuildContext context, int index) => Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 8.0),
                      child: Row(
                        children: [
                          Icon(Icons.filter_list, size: 14,),
                          Container(
                            margin: const EdgeInsets.only(left: 4.0),
                            child: Text(
                              'Filtry',
                              style: TextStyle(fontSize: 12, ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Text(
              'Znalezione promocje',
              style: TextStyle(fontSize: 18),
            ),
            FutureBuilder(
              future: Provider.of<Deals>(context, listen: false).fetchDeals(),
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
}
