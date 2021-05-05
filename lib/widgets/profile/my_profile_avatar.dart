import 'dart:io';

import 'package:BSApp/models/user_model.dart';
import 'package:BSApp/providers/users.dart';
import 'package:BSApp/util/fake_data_provider.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/widgets/common/user_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class MyProfileAvatar extends StatelessWidget {

  final UserModel user;

  MyProfileAvatar(this.user);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, left: 4.0, right: 4.0),
          child: UserAvatar(
            username: user.username,
            imagePath: FakeDataProvider.USER_AVATAR_PATH,
            image: user.avatar,
            radius: 40,
          ),
        ),
        Positioned(
          right: 2.0,
          bottom: 4.0,
          child: GestureDetector(
            onTap: () {
              _takePicture(context);
            },
            behavior: HitTestBehavior.translucent,
            child: Container(
              alignment: Alignment.center,
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: MyColorsProvider.DEEP_BLUE,
                border: Border.all(color: Colors.white, width: 2.0),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Icon(
                Icons.edit,
                size: 13,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }


  Future<void> _takePicture(BuildContext context) async {
    final imageFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );
    if (imageFile == null) {
      return;
    }
    final File newAvatar = File(imageFile.path);
    await Provider.of<Users>(context, listen: false).updateMyAvatar(newAvatar);
  }
}
