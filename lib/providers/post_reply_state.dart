import 'package:flutter/material.dart';

class PostReplyState with ChangeNotifier {

  ReplyState _currentReplyState = ReplyState.NONE;
  String _postIdToReply;

  ReplyState get replyState {
    return _currentReplyState;
  }

  String get postId {
    return _postIdToReply;
  }

  void resetLazy() {
    _postIdToReply = postId;
    _currentReplyState = replyState;
  }

  void reset() {
    this._postIdToReply = null;
  }

  void startPostReply(String postId) {
    _postIdToReply = postId;
    notifyListeners();
  }
}

enum ReplyState {
  REPLY_DEAL,
  REPLY_COMMENT,
  NONE
}
