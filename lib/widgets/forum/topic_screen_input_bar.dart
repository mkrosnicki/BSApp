import 'package:BSApp/models/post_model.dart';
import 'package:BSApp/providers/auth.dart';
import 'package:BSApp/providers/posts.dart';
import 'package:BSApp/screens/authentication/auth_screen_provider.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/util/my_icons_provider.dart';
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
              return Container(
                color: MyColorsProvider.SUPER_LIGHT_GREY,
                padding: const EdgeInsets.only(left: 14.0, right: 10.0),
                height: 40,
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Odpowiadasz na post...',
                      style:
                          const TextStyle(color: Colors.black54, fontSize: 13),
                    ),
                    InkWell(
                      child: MyIconsProvider.CLEAR_BLACK_ICON,
                      onTap: () {
                        postToReplySubject.add(null);
                      },
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
                  style: TextStyle(fontSize: 14),
                  autofocus: false,
                  decoration: MyStylingProvider.REPLY_TEXT_FIELD_DECORATION.copyWith(hintText: 'Napisz...'),
                ),
              ),
              Consumer<Auth>(
                builder: (context, authData, child) => StreamBuilder(
                  stream: _postToReplyStream,
                  builder: (context, AsyncSnapshot<PostModel> snapshot) {
                    return InkWell(
                      onTap: () => _addReply(context, authData.isAuthenticated, snapshot.data),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          CupertinoIcons.chevron_right,
                          color: Colors.blue,
                        ),
                      ),
                    );
                  }
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _addReply(BuildContext context, bool isUserLoggedIn, PostModel postToReply) async {
    if (textEditingController.text.trim().isEmpty) {
      return null;
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

  _addReplyToPost(BuildContext context, PostModel postToReply) async {
    await Provider.of<Posts>(context, listen: false).addReplyToPost(
        topicId, postToReply.id, textEditingController.text, postToReply.content);
    _clearTextBox();
    postToReplySubject.add(null);
  }

  _addPostToTopic(BuildContext context) async {
    await Provider.of<Posts>(context, listen: false)
        .addPostToTopic(topicId, textEditingController.text);
    _clearTextBox();
  }

  _clearTextBox() {
    textEditingController.clear();
    textFocusNode.unfocus();
  }
}
