import 'package:BSApp/models/comment_model.dart';
import 'package:BSApp/providers/auth.dart';
import 'package:BSApp/providers/comments.dart';
import 'package:BSApp/screens/authentication/auth_screen_provider.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/util/my_icons_provider.dart';
import 'package:BSApp/util/my_styling_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class DealDetailsNewComment extends StatefulWidget {

  final String dealId;
  final PublishSubject<CommentModel> commentToReplySubject;

  DealDetailsNewComment(this.dealId, this.commentToReplySubject);

  Stream<CommentModel> get _commentToReplyStream => commentToReplySubject.stream;

  @override
  _DealDetailsNewCommentState createState() => _DealDetailsNewCommentState();
}

class _DealDetailsNewCommentState extends State<DealDetailsNewComment> {

  TextEditingController textEditingController = TextEditingController();
  FocusNode textFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder(
          stream: widget._commentToReplyStream,
          builder: (context, AsyncSnapshot<CommentModel> snapshot) {
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
                          'Odpowiadasz na komentarz ',
                          style: const TextStyle(
                              color: Colors.black87, fontSize: 12),
                        ),
                        Text(
                          '@${snapshot.data.adderInfo.username}',
                          style: const TextStyle(
                              color: MyColorsProvider.DEEP_BLUE,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    InkWell(
                      child: const Icon(
                        CupertinoIcons.clear,
                        color: Colors.black54,
                        size: 16,
                      ),
                      onTap: () {
                        widget.commentToReplySubject.add(null);
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
                  style: const TextStyle(fontSize: 14),
                  autofocus: false,
                  decoration: MyStylingProvider.TEXT_FIELD_DECORATION.copyWith(hintText: 'Twój komentarz...'),
                ),
              ),
              Consumer<Auth>(
                builder: (context, authData, child) {
                  return StreamBuilder(
                    stream: widget._commentToReplyStream,
                    builder: (context, AsyncSnapshot<CommentModel> snapshot) {
                      return InkWell(
                        onTap: () => _addReply(authData.isAuthenticated, snapshot.data),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            CupertinoIcons.chevron_right,
                            color: Colors.blue,
                          ),
                        ),
                      );
                    }
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  _addReply(bool isUserLoggedIn, CommentModel commentToReply) async {
    if (textEditingController.text.trim().isEmpty) {
      return null;
    }
    if (!isUserLoggedIn) {
      AuthScreenProvider.showLoginScreen(context);
    } else {
      if (commentToReply == null) {
        _addCommentToDeal();
      } else {
        _addReplyToComment(commentToReply);
      }
    }
  }

  _addReplyToComment(CommentModel commentToReply) async {
    await Provider.of<Comments>(context, listen: false).addReplyToComment(
        widget.dealId, commentToReply.id, textEditingController.text);
    _clearTextBox();
    widget.commentToReplySubject.add(null);
  }

  _addCommentToDeal() async {
    await Provider.of<Comments>(context, listen: false)
        .addCommentToDeal(widget.dealId, textEditingController.text);
    _clearTextBox();
  }

  _clearTextBox() {
    textEditingController.clear();
    textFocusNode.unfocus();
  }
}
