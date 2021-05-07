import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class UserModel {
  final String id;
  final String username;
  final DateTime registeredAt;
  final DateTime lastLoginAt;
  final DateTime notificationsSeenAt;
  final Uint8List avatar;

  UserModel(
      {this.id,
        this.username,
        this.registeredAt,
        this.lastLoginAt,
        this.notificationsSeenAt,
        this.avatar});

  static UserModel fromJson(dynamic userSnapshot) {
    var registeredAt = userSnapshot['registeredAt'];
    var lastLoginAt = userSnapshot['lastLoginAt'];
    var notificationsSeenAt = userSnapshot['notificationsSeenAt'];
    return UserModel(
        id: userSnapshot['id'],
        username: userSnapshot['username'],
        registeredAt:
        registeredAt != null ? DateTime.parse(registeredAt) : null,
        lastLoginAt: lastLoginAt != null ? DateTime.parse(lastLoginAt) : null,
        notificationsSeenAt: notificationsSeenAt != null
            ? DateTime.parse(notificationsSeenAt)
            : null,
        avatar: _getAvatar(userSnapshot));
  }

  static _getAvatar(userSnapshot) {
    var encodedAvatar = userSnapshot['avatar'];
    print(encodedAvatar);
    if (encodedAvatar == null) {
      return null;
    }
    print(base64Decode(encodedAvatar));
    return base64Decode(encodedAvatar);
  }

  Uint8List get avatarBytes {
    return avatar;
  }

  Image get getAvatar {
    return avatar != null ? Image.memory(avatar) : null;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is UserModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'UserModel{id: $id, username: $username, registeredAt: $registeredAt, lastLoginAt: $lastLoginAt, notificationsSeenAt: $notificationsSeenAt, avatar: $avatar}';
  }
}
