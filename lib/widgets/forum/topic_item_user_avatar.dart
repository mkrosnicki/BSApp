import 'package:BSApp/models/adder_info_model.dart';
import 'package:BSApp/util/fake_data_provider.dart';
import 'package:BSApp/widgets/common/user_avatar.dart';
import 'package:flutter/material.dart';

class TopicItemUserAvatar extends StatelessWidget {

  final AdderInfoModel adderInfo;

  TopicItemUserAvatar(this.adderInfo);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 0.0),
      child: UserAvatar(
        username: adderInfo.username,
        imagePath: FakeDataProvider.USER_AVATAR_PATH,
        radius: 20,
      ),
    );
  }
}
