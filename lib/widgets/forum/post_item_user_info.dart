import 'package:BSApp/models/adder_info_model.dart';
import 'package:BSApp/screens/users/user_profile_screen.dart';
import 'package:BSApp/util/date_util.dart';
import 'package:BSApp/widgets/common/user_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostItemUserInfo extends StatelessWidget {
  final AdderInfoModel adderInfo;
  final DateTime addedAt;

  const PostItemUserInfo(this.adderInfo, this.addedAt);

  @override
  Widget build(BuildContext context) {
    const userInfoTextStyle = const TextStyle(
      fontSize: 11,
      color: Colors.black54,
      height: 1.4
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 0.0),
      child: Flex(
        direction: Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          UserAvatar(username: adderInfo.username, radius: 15,),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(4.0),
              margin: const EdgeInsets.only(left: 4.0),
              child: Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.zero,
                            child: GestureDetector(
                              onTap: () => _navigateToUserProfileScreen(
                                  context, adderInfo.id),
                              child: Text(
                                adderInfo.username,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            '${adderInfo.addedPosts} posty',
                            style: userInfoTextStyle,
                          ),
                        ],
                      ),
                      Text(
                        // '${_dateFormat.format(comment.addedAt)}',
                        '${DateUtil.timeAgoString(addedAt)}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(fontSize: 11, color: Colors.black38),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _navigateToUserProfileScreen(BuildContext context, String userId) {
    Navigator.of(context)
        .pushNamed(UserProfileScreen.routeName, arguments: userId);
  }
}
