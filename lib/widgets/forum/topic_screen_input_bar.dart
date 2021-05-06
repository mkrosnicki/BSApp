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

  TextEditingController textEditingController = TextEditingController();
  FocusNode textFocusNode = FocusNode();

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
                color: MyColorsProvider.SUPER_LIGHT_GREY,
                padding: const EdgeInsets.only(left: 14.0, right: 10.0),
                height: 40,
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Wrap(
                      children: [
                        const Text(
                          'Odpowiadasz na post ',
                          style: TextStyle(
                              color: Colors.black54, fontSize: 13),
                        ),
                        Text(
                          '@${snapshot.data.adderInfo.username}',
                          style: const TextStyle(
                              color: MyColorsProvider.BLUE,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        postToReplySubject.add(null);
                      },
                      child: const Icon(
                        CupertinoIcons.clear,
                        color: Colors.black54,
                        size: 16,
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
          width: double.infinity,
          // height: MediaQuery.of(context).size.height * 0.1,
          height: 50.0,
          padding: const EdgeInsets.only(left: 10.0),
          decoration: const BoxDecoration(
            border: MyStylingProvider.TOP_GREY_BORDER,
            color: Colors.white,
          ),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Flexible(
                child: TextField(
                  controller: textEditingController,
                  focusNode: textFocusNode,
                  style: const TextStyle(fontSize: 14),
                  decoration: MyStylingProvider.TEXT_FIELD_DECORATION
                      .copyWith(hintText: 'Napisz post...'),
                ),
              ),
              Consumer<Auth>(
                builder: (context, authData, child) => StreamBuilder(
                    stream: _postToReplyStream,
                    builder: (context, AsyncSnapshot<PostModel> snapshot) {
                      return InkWell(
                        onTap: () => _addReply(
                            context, authData.isAuthenticated, snapshot.data),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            CupertinoIcons.chevron_right,
                            color: Colors.blue,
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _addReply(
      BuildContext context, bool isUserLoggedIn, PostModel postToReply) async {
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
    await Provider.of<Posts>(context, listen: false).addReplyToPost(topicId,
        postToReply.id, textEditingController.text, postToReply.content);
    _clearTextBox();
    postToReplySubject.add(null);
  }

  Future<void> _addPostToTopic(BuildContext context) async {
    await Provider.of<Posts>(context, listen: false)
        .addPostToTopic(topicId, textEditingController.text);
    _clearTextBox();
  }

  void _clearTextBox() {
    textEditingController.clear();
    textFocusNode.unfocus();
  }
}
