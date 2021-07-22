import 'dart:convert';
import 'dart:typed_data';

import 'package:BSApp/util/date_util.dart';
import 'package:flutter/material.dart';

class AdderInfoModel {
  final String id;
  final String username;
  final DateTime registeredAt;
  final int addedDeals;
  final int addedComments;
  final int addedPosts;
  final int addedTopics;
  final Uint8List avatar;
  final String imagePath;

  AdderInfoModel(
      {this.id,
      this.username,
      this.registeredAt,
      this.addedDeals,
      this.addedComments,
      this.addedPosts,
      this.addedTopics,
      this.avatar,
      this.imagePath,
      });

  static AdderInfoModel fromJson(dynamic adderInfoSnapshot) {
    if (adderInfoSnapshot == null) {
      return null;
    }
    return AdderInfoModel(
      id: adderInfoSnapshot['id'],
      username: adderInfoSnapshot['username'],
      registeredAt: DateUtil.parseFromStringToUtc(adderInfoSnapshot['registeredAt']),
      addedDeals: adderInfoSnapshot['addedDeals'],
      addedComments: adderInfoSnapshot['addedComments'],
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
