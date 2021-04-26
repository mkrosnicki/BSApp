import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/models/topic_model.dart';
import 'package:BSApp/widgets/deals/deal_item.dart';
import 'package:BSApp/widgets/forum/topic_item.dart';
import 'package:flutter/material.dart';

class UserProfileAddedTopics extends StatelessWidget {
  final List<TopicModel> addedTopics;

  UserProfileAddedTopics(this.addedTopics);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        margin: const EdgeInsets.only(top: 6.0),
        child: ListView.builder(
          itemCount: addedTopics.length,
          itemBuilder: (context, index) {
            return TopicItem(addedTopics[index]);
          },
        ),
      ),
    );
  }
}
