import 'package:BSApp/models/user_model.dart';
import 'package:BSApp/util/date_util.dart';
import 'package:flutter/material.dart';

class UserProfileMainInfo extends StatelessWidget {

  final UserModel user;

  UserProfileMainInfo(this.user);

  @override
  Widget build(BuildContext context) {
    var userInfoTextStyle = const TextStyle(
      fontSize: 13,
      color: Colors.grey,
    );
    var userInfoBoldTextStyle = const TextStyle(
        fontSize: 13, color: Colors.grey, fontWeight: FontWeight.bold);
    return Container(
      color: Colors.white,
      height: 100,
      padding: EdgeInsets.all(8.0),
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
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 6.0),
                        child: GestureDetector(
                          onTap: () => {},
                          child: Text(
                            '${user.username}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Dołączył(a) : ',
                        style: userInfoBoldTextStyle,
                      ),
                      Text(
                        '${DateUtil.getFormatted(user.registeredAt)}',
                        style: userInfoTextStyle,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          CircleAvatar(
            minRadius: 35,
            maxRadius: 35,
            backgroundImage: NetworkImage(
              'https://img.favpng.com/25/13/19/samsung-galaxy-a8-a8-user-login-telephone-avatar-png-favpng-dqKEPfX7hPbc6SMVUCteANKwj.jpg',
            ),
          ),
        ],
      ),
    );
  }
}
