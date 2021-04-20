import 'package:BSApp/models/user_model.dart';
import 'package:BSApp/util/date_util.dart';
import 'package:BSApp/widgets/common/user_avatar.dart';
import 'package:flutter/material.dart';

class UserProfileMainInfo extends StatelessWidget {
  final UserModel user;

  UserProfileMainInfo(this.user);

  @override
  Widget build(BuildContext context) {
    var userInfoTextStyle = const TextStyle(
      fontSize: 12,
      color: Colors.grey,
    );
    return Container(
      color: Colors.white,
      // height: 100,
      padding: EdgeInsets.all(10.0),
      child: Flex(
        direction: Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(4.0),
              margin: const EdgeInsets.only(left: 4.0),
              child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: UserAvatar(
                      username: user.username,
                      radius: 25,
                    ),
                  ),
                  Flex(
                    direction: Axis.vertical,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 2.0),
                        child: GestureDetector(
                          onTap: () => {},
                          child: Text(
                            '${user.username}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Wrap(
                        children: [
                          Text(
                            'Dołączył(a) ',
                            style: userInfoTextStyle,
                          ),
                          Text(
                            '${DateUtil.getFormatted(user.registeredAt)}',
                            style: userInfoTextStyle,
                          ),
                        ],
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
}
