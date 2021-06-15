import 'package:BSApp/models/add_deal_model.dart';
import 'package:BSApp/models/location_type.dart';
import 'package:BSApp/widgets/bars/app_bar_add_deal.dart';
import 'package:BSApp/widgets/deals/form/coupon_form.dart';
import 'package:BSApp/widgets/deals/form/occasion_form.dart';
import 'package:flutter/material.dart';

class AddDealScreen extends StatefulWidget {
  static const routeName = '/add-deal';

  @override
  _AddDealScreenState createState() => _AddDealScreenState();
}

class _AddDealScreenState extends State<AddDealScreen> {
  final _newDeal = AddDealModel();

  @override
  void initState() {
    super.initState();
    _newDeal.locationType = LocationType.INTERNET;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarAddDeal(),
        body: SafeArea(
          child: TabBarView(
            children: [OccasionForm(_newDeal), CouponForm(_newDeal)],
          ),
        ),
      ),
    );
  }
}