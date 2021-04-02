import 'package:BSApp/screens/forum/forum_category_screen.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/util/my_icons_provider.dart';
import 'package:flutter/material.dart';

class ForumCategoryItem extends StatelessWidget {
  final String title;
  final String description;
  final String id;

  const ForumCategoryItem({this.title, this.description, this.id});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.zero,
      child: ListTile(
        tileColor: Colors.white,
        title: Text(title, style: TextStyle(fontSize: 14),),
        subtitle: Text(description, style: TextStyle(fontSize: 12),),
        trailing: MyIconsProvider.FORWARD_ICON,
        focusColor: Colors.grey,
      ),
      shape: Border(bottom: const BorderSide(color: MyColorsProvider.GREY_BORDER_COLOR, width: 0.5)),
      onPressed: () => _navigateToForum(context),
    );
  }

  void _navigateToForum(BuildContext context) async {
    Navigator.of(context).pushNamed(ForumCategoryScreen.routeName, arguments: id);
  }
}
