import 'dart:convert';
import 'dart:typed_data';

import 'package:BSApp/util/date_util.dart';
import 'package:flutter/material.dart';

class ForumUsersInfo {
  final String id;
  final String username;
  final DateTime registeredAt;
  final int addedPosts;
  final int addedTopics;
  final Uint8List avatar;
  final String imagePath;

  ForumUsersInfo(
      {this.id,
      this.username,
      this.registeredAt,
      this.addedPosts,
      this.addedTopics,
      this.avatar,
      this.imagePath,
      });

  static ForumUsersInfo fromJson(dynamic adderInfoSnapshot) {
    return ForumUsersInfo(
      id: adderInfoSnapshot['id'],
      username: adderInfoSnapshot['username'],
      registeredAt: DateUtil.parseFromStringToUtc(adderInfoSnapshot['registeredAt']),
      addedPosts: adderInfoSnapshot['addedPosts'],
      addedTopics: adderInfoSnapshot['addedTopics'],
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
