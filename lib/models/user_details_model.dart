import 'dart:convert';
import 'dart:typed_data';

import 'package:BSApp/models/user_role.dart';
import 'package:BSApp/util/date_util.dart';
import 'package:flutter/material.dart';

class UserDetailsModel {
  final String id;
  final String username;
  final UserRole userRole;
  final DateTime registeredAt;
  final DateTime lastLoginAt;
  final DateTime bannedUntil;
  final DateTime notificationsSeenAt;
  final Uint8List avatar;
  final String imagePath;
  final int pointsForDeals;
  final int likesCount;
  final double activityPerDay;
  final bool receiveEmails;
  final bool hideAvatar;

  UserDetailsModel(
      {this.id,
      this.username,
      this.userRole,
      this.registeredAt,
      this.lastLoginAt,
      this.bannedUntil,
      this.notificationsSeenAt,
      this.avatar,
      this.imagePath,
      this.pointsForDeals,
      this.likesCount,
      this.activityPerDay,
      this.receiveEmails,
      this.hideAvatar,
      });

  static UserDetailsModel fromJson(dynamic userSnapshot) {
    final registeredAt = userSnapshot['registeredAt'] as String;
    final lastLoginAt = userSnapshot['lastLoginAt'] as String;
    final bannedUntil = userSnapshot['bannedUntil'] as String;
    final notificationsSeenAt = userSnapshot['notificationsSeenAt'] as String;
    return UserDetailsModel(
      id: userSnapshot['id'] as String,
      username: userSnapshot['username'] as String,
      userRole: UserRoleHelper.fromString(userSnapshot['userRole']),
      registeredAt: registeredAt != null ? DateUtil.parseFromStringToUtc(registeredAt) : null,
      bannedUntil: bannedUntil != null ? DateUtil.parseFromStringToUtc(bannedUntil) : null,
      lastLoginAt: lastLoginAt != null ? DateUtil.parseFromStringToUtc(lastLoginAt) : null,
      notificationsSeenAt: notificationsSeenAt != null ? DateUtil.parseFromStringToUtc(notificationsSeenAt) : null,
      avatar: _getAvatar(userSnapshot),
      pointsForDeals: userSnapshot['pointsForDeals'],
      imagePath: userSnapshot['imagePath'],
      likesCount: userSnapshot['likesCount'],
      activityPerDay: userSnapshot['activityPerDay'],
      receiveEmails: userSnapshot['receiveEmails'],
      hideAvatar: userSnapshot['hideAvatar'],
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

  bool get isAdmin {
    return userRole == UserRole.ROLE_ADMIN;
  }

  bool get isBanned {
    return bannedUntil != null && bannedUntil.isAfter(DateTime.now().toUtc());
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is UserDetailsModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'UserModel{id: $id, username: $username, userRole: $userRole, registeredAt: $registeredAt, lastLoginAt: $lastLoginAt, notificationsSeenAt: $notificationsSeenAt, avatar: $avatar}';
  }
}
