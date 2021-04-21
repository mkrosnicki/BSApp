import 'package:BSApp/util/my_styling_provider.dart';
import 'package:BSApp/widgets/bars/app_bar_close_button.dart';
import 'package:BSApp/widgets/bars/base_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewTopicScreen extends StatelessWidget {
  static const routeName = '/new-topic';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Nowy temat',
        leading: const AppBarCloseButton(Colors.black),
        actions: [
          TextButton(
            onPressed: () {},
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
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Tytuł',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
            TextFormField(
              decoration:
                  MyStylingProvider.REPLY_TEXT_FIELD_DECORATION.copyWith(
                      // hintText: 'Tytuł',
                      hintStyle: TextStyle(
                        fontSize: 13,
                      )),
              obscureText: false,
              cursorColor: Colors.black,
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
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Treść',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            TextFormField(
              minLines: 10,
              maxLines: 10,
              decoration:
                  MyStylingProvider.REPLY_TEXT_FIELD_DECORATION.copyWith(
                hintText: 'Treść',
              ),
              obscureText: false,
              cursorColor: Colors.black,
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
