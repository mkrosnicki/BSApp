import 'package:BSApp/models/post_model.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/util/my_icons_provider.dart';
import 'package:BSApp/util/my_styling_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class TopicScreenInputBar extends StatelessWidget {
  final PublishSubject<PostModel> postToReplySubject;

  TopicScreenInputBar(this.postToReplySubject);

  Stream<PostModel> get _postToReplyStream => postToReplySubject.stream;

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
                  style: TextStyle(fontSize: 14),
                  autofocus: false,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Napisz...',
                    filled: true,
                    isDense: true,
                    fillColor: MyColorsProvider.SUPER_LIGHT_GREY,
                    contentPadding: const EdgeInsets.only(
                        left: 12.0, right: 12.0, bottom: 8.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(style: BorderStyle.none),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(
                          color: MyColorsProvider.SUPER_LIGHT_GREY),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onChanged: (value) {
                    // setState(() {
                    //   _commentText = value;
                    // });
                  },
                ),
              ),
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    CupertinoIcons.chevron_right,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
