import 'package:BSApp/models/user_details_model.dart';
import 'package:BSApp/util/date_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserProfileUsername extends StatelessWidget {

  final UserDetailsModel user;

  const UserProfileUsername(this.user);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(user.username, style: const TextStyle(color: Colors.black87, fontSize: 18),),
        Wrap(
          children: [
            const Text(
              'Dołączył(a) ',
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey,
              ),
            ),
            Text(
              DateUtil.getFormatted(user.registeredAt),
              style: const TextStyle(
                fontSize: 11,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
