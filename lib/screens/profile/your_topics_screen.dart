import 'package:BSApp/models/topic_model.dart';
import 'package:BSApp/widgets/bars/app_bar_back_button.dart';
import 'package:BSApp/widgets/bars/base_app_bar.dart';
import 'package:BSApp/widgets/forum/topic_item.dart';
import 'package:flutter/material.dart';

class YourTopicsScreen extends StatelessWidget {
  static const routeName = '/added-topics';

  @override
  Widget build(BuildContext context) {
    final List<TopicModel> addedTopics =
        ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: const BaseAppBar(
        leading: AppBarBackButton(Colors.black),
        title: 'Twoje tematy',
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => TopicItem(addedTopics[index]),
        itemCount: addedTopics.length,
      ),
    );
  }
}
