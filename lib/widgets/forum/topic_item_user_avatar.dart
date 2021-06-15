import 'package:BSApp/models/adder_info_model.dart';
import 'package:BSApp/models/topic_model.dart';
import 'package:BSApp/util/fake_data_provider.dart';
import 'package:BSApp/widgets/common/user_avatar.dart';
import 'package:flutter/material.dart';

class TopicItemUserAvatar extends StatelessWidget {

  final TopicModel topicModel;

  const TopicItemUserAvatar(this.topicModel);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: UserAvatar(
        username: topicModel.adderName,
        image: topicModel.userAvatar,
        imagePath: topicModel.userImagePath,
        radius: 20,
      ),
    );
  }
}
