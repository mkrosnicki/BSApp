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

class _AddDealScreenState extends State<AddDealScreen> with TickerProviderStateMixin {
  final _newDeal = AddDealModel();

  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _newDeal.locationType = LocationType.INTERNET;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarAddDeal(_tabController),
        body: TabBarView(
          controller: _tabController,
          children: [OccasionForm(_newDeal), CouponForm(_newDeal)],
        ),
      ),
    );
  }
}