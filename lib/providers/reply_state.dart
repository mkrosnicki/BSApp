import 'package:BSApp/models/comment_model.dart';
import 'package:BSApp/models/post_model.dart';
import 'package:flutter/material.dart';

class ReplyState with ChangeNotifier {

  CommentModel _aCommentToReply;
  PostModel _aPostToReply;

  CommentModel get commentToReply {
    return _aCommentToReply;
  }

  PostModel get postToReply {
    return _aPostToReply;
  }

  bool get hasCommentToReply {
    return _aCommentToReply != null;
  }

  bool get hasPostToReply {
    return _aPostToReply != null;
  }

  void setCommentToReply(final CommentModel comment) {
    if (commentToReply != comment) {
      _aCommentToReply = comment;
      notifyListeners();
    }
  }

  void setTopicToReply(final PostModel post) {
    if (postToReply != post) {
      _aPostToReply = post;
      notifyListeners();
    }
  }

  void clearState() {
    if (_aCommentToReply != null || _aPostToReply != null) {
      _aCommentToReply = null;
      _aPostToReply = null;
      notifyListeners();
    }
  }

}