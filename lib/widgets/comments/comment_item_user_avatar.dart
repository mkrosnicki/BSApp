import 'package:BSApp/models/adder_info_model.dart';
import 'package:BSApp/models/comment_model.dart';
import 'package:BSApp/util/fake_data_provider.dart';
import 'package:BSApp/widgets/common/user_avatar.dart';
import 'package:flutter/material.dart';

class CommentItemUserAvatar extends StatelessWidget {
  final CommentModel commentModel;

  const CommentItemUserAvatar(this.commentModel);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 4.0, top: 4.0),
      child: UserAvatar(
        username: commentModel.adderName,
        imagePath: commentModel.userImagePath,
        image: commentModel.userAvatar,
        radius: 16,
      ),
    );
  }
}
