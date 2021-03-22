import 'package:flutter/material.dart';

class DealReplyState with ChangeNotifier {

  ReplyState _currentReplyState = ReplyState.NONE;
  String _commentIdToReply;

  ReplyState get replyState {
    return _currentReplyState;
  }

  String get commentId {
    return _commentIdToReply;
  }

  void reset() {
    _setReplyState(ReplyState.NONE, null);
  }

  void startDealReply() {
    _setReplyState(ReplyState.REPLY_DEAL, null);
  }

  void startCommentReply(String commentId) {
    _setReplyState(ReplyState.REPLY_COMMENT, commentId);
  }

  void _setReplyState(ReplyState replyState, String commentId) {
    _commentIdToReply = commentId;
    _currentReplyState = replyState;
    notifyListeners();
  }
}

enum ReplyState {
  REPLY_DEAL,
  REPLY_COMMENT,
  NONE
}
