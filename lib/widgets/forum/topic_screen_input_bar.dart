import 'package:BSApp/models/post_model.dart';
import 'package:BSApp/providers/auth.dart';
import 'package:BSApp/providers/posts.dart';
import 'package:BSApp/screens/authentication/auth_screen_provider.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/util/my_styling_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class TopicScreenInputBar extends StatelessWidget {
  final String topicId;
  final PublishSubject<PostModel> postToReplySubject;

  TopicScreenInputBar(this.topicId, this.postToReplySubject);

  Stream<PostModel> get _postToReplyStream => postToReplySubject.stream;

  final TextEditingController textEditingController = TextEditingController();
  final FocusNode textFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder(
          stream: _postToReplyStream,
          builder: (context, AsyncSnapshot<PostModel> snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              textFocusNode.requestFocus();
              return Container(
                padding: const EdgeInsets.only(left: 14.0, right: 10.0),
                height: 40,
                color: MyColorsProvider.SUPER_LIGHT_GREY,
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
                          '${snapshot.data.adderInfo.username}',
                          style: const TextStyle(color: Colors.black54, fontSize: 11, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        postToReplySubject.add(null);
                      },
                      child: const Icon(
                        CupertinoIcons.clear,
                        color: MyColorsProvider.DEEP_BLUE,
                        size: 19,
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
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
            decoration: const BoxDecoration(
              border: MyStylingProvider.TOP_GREY_BORDER_THICK,
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
                        focusNode: textFocusNode,
                        style: const TextStyle(fontSize: 13),
                        decoration: MyStylingProvider.POST_COMMENT_BOTTOM_TEXT_FIELD_DECORATION
                            .copyWith(hintText: 'Napisz post...'),
                      ),
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Consumer<Auth>(
                            builder: (context, authData, child) => StreamBuilder(
                                stream: _postToReplyStream,
                                builder: (context, AsyncSnapshot<PostModel> snapshot) {
                                  return InkWell(
                                    onTap: () => _addReply(context, authData.isAuthenticated, snapshot.data),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Icon(
                                        CupertinoIcons.chevron_right,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _addReply(BuildContext context, bool isUserLoggedIn, PostModel postToReply) async {
    if (textEditingController.text.trim().isEmpty) {
      return;
    }
    if (!isUserLoggedIn) {
      AuthScreenProvider.showLoginScreen(context);
    } else {
      if (postToReply == null) {
        _addPostToTopic(context);
      } else {
        _addReplyToPost(context, postToReply);
      }
    }
  }

  Future<void> _addReplyToPost(BuildContext context, PostModel postToReply) async {
    await Provider.of<Posts>(context, listen: false)
        .addReplyToPost(topicId, postToReply.id, textEditingController.text, postToReply.content);
    _clearTextBox();
    postToReplySubject.add(null);
  }

  Future<void> _addPostToTopic(BuildContext context) async {
    await Provider.of<Posts>(context, listen: false).addPostToTopic(topicId, textEditingController.text);
    _clearTextBox();
  }

  void _clearTextBox() {
    textEditingController.clear();
    textFocusNode.unfocus();
  }
}
