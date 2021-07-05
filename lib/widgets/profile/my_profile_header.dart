
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
      width: double.infinity,
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        children: [
          MyProfileAvatar(user),
          Container(
            margin: const EdgeInsets.only(bottom: 2.0),
            child: GestureDetector(
              onTap: () => {},
              child: Text(
                user.username,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
