import 'dart:typed_data';

import 'package:BSApp/util/date_util.dart';

import 'deals_users_info_model.dart';

class CommentModel {
  final String id;
  final String content;
  final String quote;
  final int subCommentsCount;
  final String parentId;
  final String repliedId;
  final String repliedUserId;
  final String repliedUsername;
  final DateTime addedAt;
  final DealsUsersInfo adderInfo;
  final List<String> likers;

  CommentModel(
      {this.id,
      this.content,
      this.quote,
      this.subCommentsCount,
      this.parentId,
      this.repliedId,
      this.repliedUserId,
      this.repliedUsername,
      this.addedAt,
      this.adderInfo,
      this.likers});

  static List<CommentModel> fromJsonList(List<dynamic> commentsSnapshot) {
    final List<CommentModel> comments = [];
    for (final commentSnapshot in commentsSnapshot) {
      comments.add(fromJson(commentSnapshot));
    }
    return comments;
  }

  static CommentModel fromJson(dynamic commentSnapshot) {
    if (commentSnapshot == null) {
      return null;
    }
    return CommentModel(
      id: commentSnapshot['id'] as String,
      content: commentSnapshot['content'] as String,
      quote: commentSnapshot['quote'] as String,
      parentId: commentSnapshot['parentId'] as String,
      repliedId: commentSnapshot['repliedId'] as String,
      repliedUserId: commentSnapshot['repliedUserId'] as String,
      repliedUsername: commentSnapshot['repliedUsername'] as String,
      subCommentsCount: commentSnapshot['subCommentsCount'],
      addedAt: DateUtil.parseFromStringToUtc(commentSnapshot['addedAt'] as String),
      adderInfo: DealsUsersInfo.fromJson(commentSnapshot['adderInfo']),
      likers: [...commentSnapshot['likers'] as List],
    );
  }

  bool wasLikedBy(String userId) {
    return likers.any((element) => element == userId);
  }

  bool isParent() {
    return parentId == null;
  }

  bool isChild() {
    return !isParent();
  }

  String get adderName {
    return adderInfo != null ? adderInfo.username : 'Usunięty użytkownik';
  }

  Uint8List get userAvatar {
    return adderInfo != null ? adderInfo.avatar : null;
  }

  String get userImagePath {
    return adderInfo != null ? adderInfo.imagePath : null;
  }

  bool get hasSubComments {
    return subCommentsCount > 0;
  }

  @override
  String toString() {
    return 'CommentModel{id: $id, content: $content, subCommentsCount: $subCommentsCount, likers: ${likers.length}}';
  }
}
