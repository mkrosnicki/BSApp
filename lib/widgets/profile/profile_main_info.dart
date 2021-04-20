import 'package:BSApp/models/user_model.dart';
import 'package:BSApp/util/date_util.dart';
import 'package:BSApp/widgets/common/user_avatar.dart';
import 'package:flutter/material.dart';

class ProfileMainInfo extends StatelessWidget {
  final UserModel user;

  ProfileMainInfo(this.user);

  @override
  Widget build(BuildContext context) {
    var userInfoTextStyle = const TextStyle(
      fontSize: 11,
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
              alignment: Alignment.center,
              // padding: const EdgeInsets.all(4.0),
              // margin: const EdgeInsets.only(left: 4.0),
              child: Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: UserAvatar(
                      username: user != null ? user.username : 'fake',
                      radius: 30,
                    ),
                  ),
                  Flex(
                    direction: Axis.vertical,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 2.0),
                        child: GestureDetector(
                          onTap: () => {},
                          child: Text(
                            user != null ? '${user.username}' : '',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      if (user != null) Wrap(
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
