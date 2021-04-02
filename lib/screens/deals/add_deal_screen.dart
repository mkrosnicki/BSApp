import 'package:BSApp/widgets/bars/app_bar_add_deal.dart';
import 'package:BSApp/widgets/deals/occasion_form.dart';
import 'package:flutter/material.dart';

class AddDealScreen extends StatefulWidget {
  static const routeName = '/add-deal';

  @override
  _AddDealScreenState createState() => _AddDealScreenState();
}

class _AddDealScreenState extends State<AddDealScreen> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBarAddDeal(),
        body: TabBarView(
          children: [OccasionForm(), Text('COUPON - TO BE DONE!')],
        ),
      ),
    );
  }
}