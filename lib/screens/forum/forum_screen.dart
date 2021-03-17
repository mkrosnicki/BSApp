import 'package:BSApp/widgets/bars/my_navigation_bar.dart';
import 'package:BSApp/widgets/profile/profile_option_item.dart';
import 'package:flutter/material.dart';

class ForumScreen extends StatelessWidget {
  static const routeName = 'forum';

  @override
  Widget build(BuildContext context) {
    List<String> widgets =
        List.generate(10, (index) => 'Option number $index');
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) => ProfileOptionItem(title: widgets[index], route: widgets[index]),
        itemCount: 10,
      ),
      bottomNavigationBar: MyNavigationBar(1),
    );
  }
}
