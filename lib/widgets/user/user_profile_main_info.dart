import 'package:BSApp/models/user_model.dart';
import 'package:BSApp/util/date_util.dart';
import 'package:BSApp/widgets/common/ban_badge.dart';
import 'package:BSApp/widgets/common/user_avatar.dart';
import 'package:flutter/material.dart';

class UserProfileMainInfo extends StatelessWidget {
  final UserModel user;

  const UserProfileMainInfo(this.user);

  @override
  Widget build(BuildContext context) {
    const userInfoTextStyle = TextStyle(
      fontSize: 12,
      color: Colors.grey,
    );
    return Container(
      color: Colors.white,
      // height: 100,
      padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.center,
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
                    Container(
                      margin: const EdgeInsets.only(bottom: 2.0),
                      child: GestureDetector(
                        onTap: () => {},
                        child: Text(
                          user.username,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Wrap(
                      children: [
                        const Text(
                          'Dołączył(a) ',
                          style: userInfoTextStyle,
                        ),
                        Text(
                          DateUtil.getFormatted(user.registeredAt),
                          style: userInfoTextStyle,
                        ),
                      ],
                    ),
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
