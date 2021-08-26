import 'dart:io';

import 'package:BSApp/models/post_model.dart';
import 'package:BSApp/providers/auth.dart';
import 'package:BSApp/providers/posts.dart';
import 'package:BSApp/providers/reply_state.dart';
import 'package:BSApp/screens/authentication/auth_screen_provider.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/util/my_styling_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopicScreenInputBar extends StatefulWidget {
  final String topicId;

  const TopicScreenInputBar(this.topicId);

  @override
  _TopicScreenInputBarState createState() => _TopicScreenInputBarState();
}

class _TopicScreenInputBarState extends State<TopicScreenInputBar> {

  final TextEditingController textEditingController = TextEditingController();

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
            if (_isInitialized && replyState.hasPostToReply) {
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
                          'Odpowiadasz na post ',
                          style: TextStyle(color: Colors.black54, fontSize: 11),
                        ),
                        Text(
                          replyState.postToReply.adderName,
                          style: const TextStyle(color: Colors.black54, fontSize: 11, fontWeight: FontWeight.w600),
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
        Container(
          color: Colors.white,
          padding:
              Platform.isIOS ? EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom - 8.0) : EdgeInsets.zero,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: 50,
              maxHeight: 80,
            ),
            child: Consumer<ReplyState>(
              builder: (context, rs, child) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                  decoration: BoxDecoration(
                    border: rs.hasPostToReply ? null : MyStylingProvider.TOP_GREY_BORDER_THICK,
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
                              controller: textEditingController,
                              focusNode: _textFocusNode,
                              style: const TextStyle(fontSize: 13),
                              decoration: MyStylingProvider.POST_COMMENT_BOTTOM_TEXT_FIELD_DECORATION
                                  .copyWith(hintText: 'Napisz post...'),
                            ),
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Consumer<Auth>(
                                  builder: (context, authData, child) => InkWell(
                                    onTap: () => _addReply(context, authData.isAuthenticated),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Icon(
                                        CupertinoIcons.chevron_right,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _addReply(BuildContext context, bool isUserLoggedIn) async {
    if (textEditingController.text.trim().isEmpty) {
      return;
    }
    if (!isUserLoggedIn) {
      AuthScreenProvider.showLoginScreen(context);
    } else {
      final ReplyState replyState = Provider.of<ReplyState>(context, listen: false);
      _clearTextBox();
      if (replyState.hasPostToReply) {
        _addReplyToPost(context, replyState.postToReply);
      } else {
        _addPostToTopic(context);
      }
    }
  }

  Future<void> _addReplyToPost(BuildContext context, PostModel postToReply) async {
    await Provider.of<Posts>(context, listen: false)
        .addReplyToPost(widget.topicId, postToReply.id, textEditingController.text, postToReply.content);
    Provider.of<ReplyState>(context, listen: false).clearState();
  }

  Future<void> _addPostToTopic(BuildContext context) async {
    await Provider.of<Posts>(context, listen: false).addPostToTopic(widget.topicId, textEditingController.text);
  }

  void _setKeyboardVisible(bool open) {
    if (open) {
      _textFocusNode.requestFocus();
    } else {
      _textFocusNode.unfocus();
    }
  }

  void _clearTextBox() {
    textEditingController.clear();
    _textFocusNode.unfocus();
  }
}
