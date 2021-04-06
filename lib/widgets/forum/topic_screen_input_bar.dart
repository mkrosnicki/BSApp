import 'package:BSApp/providers/post_reply_state.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopicScreenInputBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<PostReplyState>(
          builder: (context, postReplyState, child) {
            if (postReplyState.postId != null) {
              return Container(
                color: MyColorsProvider.SUPER_LIGHT_GREY,
                padding: EdgeInsets.all(8.0),
                height: 40,
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Odpowiadasz na post...'),
                    InkWell(
                      child: Icon(CupertinoIcons.clear, color: Colors.black,),
                      onTap: () {
                        Provider.of<PostReplyState>(context, listen: false).reset();
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
          // color: Colors.white,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                  width: 0.2, color: MyColorsProvider.GREY_BORDER_COLOR),
            ),
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
                      borderSide: BorderSide(style: BorderStyle.none),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: MyColorsProvider.SUPER_LIGHT_GREY),
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
              TextButton(
                onPressed: () {},
                child: Icon(CupertinoIcons.chevron_right),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
