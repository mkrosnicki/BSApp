
import 'package:BSApp/models/user_details_model.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/widgets/profile/my_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyProfileHeader extends StatelessWidget {
  final UserDetailsModel user;

  const MyProfileHeader(this.user);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        children: [
          MyProfileAvatar(user),
        ],
      ),
    );
  }
}
