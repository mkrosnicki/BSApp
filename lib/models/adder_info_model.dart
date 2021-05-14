import 'dart:convert';
import 'dart:typed_data';

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

  AdderInfoModel(
      {this.id,
      this.username,
      this.registeredAt,
      this.addedDeals,
      this.addedComments,
      this.addedPosts,
      this.addedTopics,
      this.avatar});

  static AdderInfoModel fromJson(dynamic adderInfoSnapshot) {
    return AdderInfoModel(
      id: adderInfoSnapshot['id'],
      username: adderInfoSnapshot['username'],
      registeredAt: DateTime.parse(adderInfoSnapshot['registeredAt']),
      addedDeals: adderInfoSnapshot['addedDeals'],
      addedComments: adderInfoSnapshot['addedComments'],
      addedPosts: adderInfoSnapshot['addedPosts'],
      addedTopics: adderInfoSnapshot['addedTopics'],
      avatar: _getAvatar(adderInfoSnapshot),
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
