import 'package:BSApp/util/my_styling_provider.dart';
import 'package:BSApp/widgets/bars/app_bar_back_button.dart';
import 'package:BSApp/widgets/bars/app_bar_bottom_border.dart';
import 'package:BSApp/widgets/bars/app_bar_close_button.dart';
import 'package:BSApp/widgets/bars/my_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopicScreen extends StatelessWidget {
  static const routeName = '/topic';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Forum',
          style: MyStylingProvider.TEXT_BLACK,
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        bottom: const AppBarBottomBorder(),
        leading: const AppBarBackButton(Colors.black),
        actions: [
          const AppBarCloseButton(Colors.black),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Text(
              'Temat',
              style: TextStyle(fontSize: 22),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        child: const Icon(CupertinoIcons.reply),
        backgroundColor: Colors.deepOrange,
      ),
      bottomNavigationBar: MyNavigationBar(1),
    );
  }
}
