import 'package:BSApp/models/activity_model.dart';
import 'package:BSApp/widgets/activities/activity_item.dart';
import 'package:BSApp/widgets/bars/app_bar_back_button.dart';
import 'package:BSApp/widgets/bars/base_app_bar.dart';
import 'package:flutter/material.dart';

class YourActivityScreen extends StatelessWidget {
  static const routeName = '/your-activity';

  @override
  Widget build(BuildContext context) {
    final List<ActivityModel> activities =
        ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: BaseAppBar(
        leading: const AppBarBackButton(Colors.black),
        title: 'Twoja aktywność',
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => ActivityItem(activities[index]),
        itemCount: activities.length,
      ),
    );
  }
}
