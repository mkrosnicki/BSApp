import 'dart:convert';
import 'dart:typed_data';

import 'package:BSApp/models/user_role.dart';
import 'package:flutter/material.dart';

class UserModel {
  final String id;
  final String username;
  final UserRole userRole;
  final DateTime registeredAt;
  final DateTime lastLoginAt;
  final DateTime notificationsSeenAt;
  final Uint8List avatar;

  UserModel(
      {this.id,
        this.username,
        this.userRole,
        this.registeredAt,
        this.lastLoginAt,
        this.notificationsSeenAt,
        this.avatar});

  static UserModel fromJson(dynamic userSnapshot) {
    final registeredAt = userSnapshot['registeredAt'] as String;
    final lastLoginAt = userSnapshot['lastLoginAt'] as String;
    final notificationsSeenAt = userSnapshot['notificationsSeenAt'] as String;
    return UserModel(
        id: userSnapshot['id'] as String,
        username: userSnapshot['username'] as String,
        userRole: UserRoleHelper.fromString(userSnapshot['userRole']),
        registeredAt:
        registeredAt != null ? DateTime.parse(registeredAt) : null,
        lastLoginAt: lastLoginAt != null ? DateTime.parse(lastLoginAt) : null,
        notificationsSeenAt: notificationsSeenAt != null
            ? DateTime.parse(notificationsSeenAt)
            : null,
        avatar: _getAvatar(userSnapshot));
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is UserModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'UserModel{id: $id, username: $username, userRole: $userRole, registeredAt: $registeredAt, lastLoginAt: $lastLoginAt, notificationsSeenAt: $notificationsSeenAt, avatar: $avatar}';
  }
}
