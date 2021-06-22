
import 'package:BSApp/models/user_details_model.dart';
import 'package:BSApp/widgets/profile/my_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileUserInfo extends StatelessWidget {
  final UserDetailsModel user;

  const ProfileUserInfo(this.user);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 10.0),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Flex(
              direction: Axis.vertical,
              children: [
                MyProfileAvatar(user),
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
