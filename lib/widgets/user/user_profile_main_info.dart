import 'package:BSApp/models/user_details_model.dart';
import 'package:BSApp/util/date_util.dart';
import 'package:BSApp/widgets/common/ban_badge.dart';
import 'package:BSApp/widgets/common/user_avatar.dart';
import 'package:flutter/material.dart';

class UserProfileMainInfo extends StatelessWidget {
  final UserDetailsModel user;

  const UserProfileMainInfo(this.user);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10.0, top: 10.0, left: 5.0),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Flexible(
            child: Flex(
              direction: Axis.vertical,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: UserAvatar(
                    username: user.username,
                    image: user.avatar,
                    imagePath: user.imagePath,
                    radius: 45,
                  ),
                ),
                Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (user.isBanned) const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
                      child: BanBadge(),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
