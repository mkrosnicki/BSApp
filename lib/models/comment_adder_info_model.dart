import 'dart:convert';
import 'dart:typed_data';

import 'package:BSApp/util/date_util.dart';
import 'package:flutter/material.dart';

class CommentAdderInfoModel {
  final String id;
  final String username;
  final DateTime registeredAt;
  final Uint8List avatar;
  final String imagePath;

  CommentAdderInfoModel(
      {this.id,
      this.username,
      this.registeredAt,
      this.avatar,
      this.imagePath,
      });

  static CommentAdderInfoModel fromJson(dynamic adderInfoSnapshot) {
    return CommentAdderInfoModel(
      id: adderInfoSnapshot['id'],
      username: adderInfoSnapshot['username'],
      registeredAt: DateUtil.parseFromStringToUtc(adderInfoSnapshot['registeredAt']),
      avatar: _getAvatar(adderInfoSnapshot),
      imagePath: adderInfoSnapshot['imagePath'],
    );
  }

  static Uint8List _getAvatar(userSnapshot) {
    final encodedAvatar = userSnapshot['avatar'] as String;
    return encodedAvatar != null ? base64Decode(encodedAvatar) : null;
  }

  Uint8List get avatarBytes {
    return avatar;
  }

  Image get getAvatar {
    return avatar != null ? Image.memory(avatar) : null;
  }
}
