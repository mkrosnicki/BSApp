import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopicScreenInputBar extends StatefulWidget {
  @override
  _TopicScreenInputBarState createState() => _TopicScreenInputBarState();
}

class _TopicScreenInputBarState extends State<TopicScreenInputBar> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(color: Colors.green, height: 40),
      Container(
        width: double.infinity,
        // height: MediaQuery.of(context).size.height * 0.1,
        height: 50.0,
        padding: const EdgeInsets.only(left: 10.0),
        // color: Colors.white,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
                width: 0.2,
                color: MyColorsProvider.GREY_BORDER_COLOR),
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
                      left: 12.0,
                      right: 12.0,
                      bottom: 8.0,
                      top: 8.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(style: BorderStyle.none),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
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
            TextButton(
              onPressed: () {},
              child: Icon(CupertinoIcons.chevron_right),
            ),
          ],
        ),
      ),
    ],);
  }
}
