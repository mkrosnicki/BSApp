import 'dart:ffi';

import 'package:BSApp/providers/topics.dart';
import 'package:BSApp/screens/forum/topic_screen.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/util/my_styling_provider.dart';
import 'package:BSApp/widgets/bars/app_bar_close_button.dart';
import 'package:BSApp/widgets/bars/base_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewTopicScreen extends StatelessWidget {
  static const routeName = '/new-topic';

  @override
  Widget build(BuildContext context) {
    String categoryId = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Nowy temat',
        leading: const AppBarCloseButton(Colors.black),
        actions: [
          TextButton(
            onPressed: () {
              Provider.of<Topics>(context, listen: false)
                  .addNewTopic('aaaa', 'bbbbb', categoryId)
                  .then((topic) {
                    Navigator.of(context).popAndPushNamed(TopicScreen.routeName, arguments: topic.id);
              });
            },
            child: const Text(
              'Wyślij',
              style: MyStylingProvider.TEXT_BLUE,
            ),
          )
        ],
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              obscureText: false,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                hintText: 'Tytuł',
                hintStyle: TextStyle(fontSize: 14),
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.only(
                    left: 12.0, right: 12.0, bottom: 8.0, top: 8.0),
                focusedBorder: UnderlineInputBorder(
                  borderSide: const BorderSide(
                      color: MyColorsProvider.BLUE),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: const BorderSide(
                      color: MyColorsProvider.GREY_BORDER_COLOR),
                ),
              ),
              // controller: _newPasswordController,
              validator: (value) {
                if (value.isEmpty || value.length < 3) {
                  return 'Zbyt krótkie hasło';
                } else {
                  return null;
                }
              },
              onSaved: (value) {
                // _newPassword = value;
              },
            ),
            Padding(padding: const EdgeInsets.all(8.0),),
            TextFormField(
              minLines: 7,
              maxLines: 7,
              obscureText: false,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                hintText: 'Napisz coś...',
                hintStyle: TextStyle(fontSize: 14),
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.only(
                    left: 12.0, right: 12.0, bottom: 8.0, top: 8.0),
                focusedBorder: UnderlineInputBorder(
                  borderSide: const BorderSide(
                      color: MyColorsProvider.BLUE),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: const BorderSide(
                      color: MyColorsProvider.GREY_BORDER_COLOR),
                ),
              ),
              // controller: _newPasswordController,
              validator: (value) {
                if (value.isEmpty || value.length < 3) {
                  return 'Zbyt krótkie hasło';
                } else {
                  return null;
                }
              },
              onSaved: (value) {
                // _newPassword = value;
              },
            )
          ],
        ),
      ),
    );
  }
}
