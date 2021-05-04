import 'package:BSApp/models/adder_info_model.dart';
import 'package:BSApp/widgets/common/user_avatar.dart';
import 'package:flutter/material.dart';

class CommentItemUserAvatar extends StatelessWidget {

  final AdderInfoModel adderInfo;

  CommentItemUserAvatar(this.adderInfo);

  @override
  Widget build(BuildContext context) {
    return         Container(
      padding: const EdgeInsets.only(right: 4.0, top: 4.0),
      child: UserAvatar(
        username: adderInfo.username,
        radius: 16,
      ),
    );
  }
}