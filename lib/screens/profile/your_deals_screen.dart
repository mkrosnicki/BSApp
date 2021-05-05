import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/widgets/bars/app_bar_back_button.dart';
import 'package:BSApp/widgets/bars/base_app_bar.dart';
import 'package:BSApp/widgets/deals/deal_item.dart';
import 'package:flutter/material.dart';

class YourDealsScreen extends StatelessWidget {
  static const routeName = '/added-deals';

  @override
  Widget build(BuildContext context) {
    final List<DealModel> addedDeals =
        ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: BaseAppBar(
        leading: const AppBarBackButton(Colors.black),
        title: 'Dodane okazje',
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => DealItem(addedDeals[index]),
        itemCount: addedDeals.length,
      ),
    );
  }
}
