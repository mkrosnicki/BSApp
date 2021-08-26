import 'package:BSApp/models/comment_model.dart';
import 'package:BSApp/providers/auth.dart';
import 'package:BSApp/providers/comments.dart';
import 'package:BSApp/providers/reply_state.dart';
import 'package:BSApp/screens/authentication/auth_screen_provider.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/util/my_styling_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class DealDetailsNewComment extends StatefulWidget {
  final String dealId;

  const DealDetailsNewComment(this.dealId);

  @override
  _DealDetailsNewCommentState createState() => _DealDetailsNewCommentState();
}

class _DealDetailsNewCommentState extends State<DealDetailsNewComment> {
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _textFocusNode = FocusNode();
  bool _isInitialized = false;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Provider.of<ReplyState>(context, listen: false).clearState();
      _isInitialized = true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<ReplyState>(
          builder: (context, replyState, child) {
            if (_isInitialized && replyState.hasCommentToReply) {
              _setKeyboardVisible(true);
              return Container(
                padding: const EdgeInsets.only(left: 14.0, right: 22.0, top: 6.0),
                decoration: const BoxDecoration(
                  border: MyStylingProvider.TOP_GREY_BORDER_THICK,
                  color: Colors.white,
                ),
                height: 35,
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Wrap(
                      children: [
                        const Text(
                          'Odpowiadasz na komentarz ',
                          style: TextStyle(color: Colors.black87, fontSize: 12),
                        ),
                        Text(
                          replyState.commentToReply.adderName,
                          style: const TextStyle(color: Colors.black87, fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Provider.of<ReplyState>(context, listen: false).clearState();
                      },
                      child: const Icon(
                        CupertinoIcons.clear,
                        color: MyColorsProvider.DEEP_BLUE,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Container();
            }
          },
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: 50,
            maxHeight: 80,
          ),
          child: Consumer<ReplyState>(
            builder: (context, rs, child) {
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0, bottom: 5.0),
                decoration: BoxDecoration(
                  border: rs.hasCommentToReply ? null : MyStylingProvider.TOP_GREY_BORDER_THICK,
                  color: Colors.white,
                ),
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    Flexible(
                      child: Stack(
                        children: [
                          TextField(
                            minLines: 1,
                            maxLines: 3,
                            controller: _textEditingController,
                            focusNode: _textFocusNode,
                            style: const TextStyle(fontSize: 13),
                            decoration: MyStylingProvider.POST_COMMENT_BOTTOM_TEXT_FIELD_DECORATION
                                .copyWith(hintText: 'Twój komentarz...'),
                          ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Consumer<Auth>(
                                builder: (context, authData, child) {
                                  return Consumer<ReplyState>(
                                    builder: (context, replyState, child) {
                                      return GestureDetector(
                                        onTap: () => _addReply(authData.isAuthenticated, replyState.commentToReply),
                                        behavior: HitTestBehavior.translucent,
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                          child: Icon(
                                            CupertinoIcons.chevron_right,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _setKeyboardVisible(bool open) {
    if (open) {
      _textFocusNode.requestFocus();
    } else {
      _textFocusNode.unfocus();
    }
  }

  Future<void> _addReply(bool isUserLoggedIn, CommentModel commentToReply) async {
    if (_textEditingController.text.trim().isEmpty) {
      return;
    }
    if (!isUserLoggedIn) {
      AuthScreenProvider.showLoginScreen(context);
    } else {
      final String commentText = _textEditingController.text;
      _clearTextBox();
      if (commentToReply == null) {
        _addCommentToDeal(commentText);
      } else {
        _addReplyToComment(commentToReply, commentText);
      }
    }
  }

  Future<void> _addReplyToComment(CommentModel commentToReply, final String commentText) async {
    await Provider.of<Comments>(context, listen: false)
        .addReplyToComment(widget.dealId, commentToReply.id, commentText);
    Provider.of<ReplyState>(context, listen: false).clearState();
  }

  Future<void> _addCommentToDeal(final String commentText) async {
    await Provider.of<Comments>(context, listen: false).addCommentToDeal(widget.dealId, commentText);
  }

  void _clearTextBox() {
    _textEditingController.clear();
    _textFocusNode.unfocus();
  }
}
