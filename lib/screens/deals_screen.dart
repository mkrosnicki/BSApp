import 'package:BSApp/providers/deals.dart';
import 'package:BSApp/screens/filter_selection_screen.dart';
import 'package:BSApp/widgets/deal_item.dart';
import 'package:BSApp/widgets/my_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DealsScreen extends StatelessWidget {
  static const routeName = '/deals';

  final _searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final formFieldDecoration = InputDecoration(
      enabledBorder: InputBorder.none,
      focusedErrorBorder: InputBorder.none,
      filled: true,
      fillColor: Colors.white,
      focusColor: Colors.white,
      enabled: false,
      isDense: true,
      contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      border: UnderlineInputBorder(
        borderSide: const BorderSide(width: 0, style: BorderStyle.none),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: const BorderSide(width: 0),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap: () => _openFiltersScreen(context),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    color: Colors.white,
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        Text(
                          'gffdfdsafds',
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      // appBar: AppBar(
      //   title: Container(
      //     width: double.infinity,
      //     child: GestureDetector(
      //       child: TextFormField(
      //         decoration: formFieldDecoration,
      //         controller: _searchTextController,
      //       ),
      //       onTap: () => _openFiltersScreen(context),
      //     ),
      //   ),
      // ),
      body: FutureBuilder(
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
              return RefreshIndicator(
                onRefresh: () => _refreshDeals(context),
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
      bottomNavigationBar: MyNavigationBar(0),
    );
  }

  Future<void> _refreshDeals(BuildContext context) async {
    await Provider.of<Deals>(context, listen: false).fetchDeals();
  }

  Future _openFiltersScreen(BuildContext context) async {
    var returnedValue =
        await Navigator.of(context).push(new MaterialPageRoute<String>(
            builder: (BuildContext context) {
              return FilterSelectionScreen();
            },
            fullscreenDialog: true));
    _searchTextController.text = returnedValue;
    print(returnedValue);
  }
}
