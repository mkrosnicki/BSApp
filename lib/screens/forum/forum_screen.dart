import 'package:BSApp/util/my_icons_provider.dart';
import 'package:BSApp/util/my_styling_provider.dart';
import 'package:BSApp/widgets/bars/app_bar_bottom_border.dart';
import 'package:BSApp/widgets/bars/app_bar_button.dart';
import 'package:BSApp/widgets/bars/app_bar_close_button.dart';
import 'package:BSApp/widgets/bars/my_navigation_bar.dart';
import 'package:BSApp/widgets/forum/forum_category_item.dart';
import 'package:BSApp/widgets/forum/topic_item.dart';
import 'package:flutter/material.dart';

class ForumScreen extends StatelessWidget {
  static const routeName = '/forum';

  @override
  Widget build(BuildContext context) {
    List<String> widgets = List.generate(10, (index) => 'Option number $index');
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
        leading: AppBarButton(
          icon: MyIconsProvider.BACK_BLACK_ICON,
          onPress: () => {},
        ),
        actions: [
          const AppBarCloseButton(Colors.black),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                title: Text(
                  'Popularne wątki',
                  style: TextStyle(fontSize: 14),
                ),
                focusColor: Colors.grey,
              ),
              ...widgets
                  .sublist(0, 2)
                  .map((e) => TopicItem(title: 'a', route: 'a'))
                  .toList(),
              ListTile(
                title: Text(
                  'Kategorie',
                  style: TextStyle(fontSize: 14),
                ),
                focusColor: Colors.grey,
              ),
              ...widgets
                  .map((e) => ForumCategoryItem(title: 'a', route: 'a'))
                  .toList(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyNavigationBar(1),
    );
  }
}
