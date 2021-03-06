import 'package:BSApp/models/topic_category_model.dart';
import 'package:BSApp/screens/forum/forum_category_screen.dart';
import 'package:BSApp/util/image_assets_helper.dart';
import 'package:BSApp/util/my_icons_provider.dart';
import 'package:BSApp/util/my_styling_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForumCategoryItem extends StatelessWidget {
  final TopicCategoryModel topicCategory;

  const ForumCategoryItem(this.topicCategory);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      alignment: Alignment.center,
      margin: MyStylingProvider.ITEMS_MARGIN,
      decoration: MyStylingProvider.ITEMS_BORDER,
      padding: const EdgeInsets.all(2.0),
      child: GestureDetector(
        onTap: () => _navigateToForum(context),
        child: ListTile(
          tileColor: Colors.white,
          leading: SizedBox(
            height: 37,
            width: 37,
            child: Image.asset(
              ImageAssetsHelper.topicCategoryPath(topicCategory.name),
              fit: BoxFit.fitHeight,
            ),
          ),
          title: Text(
            topicCategory.name,
            style: const TextStyle(fontSize: 13),
          ),
          subtitle: Text(
            topicCategory.description,
            style: const TextStyle(fontSize: 12),
          ),
          trailing: MyIconsProvider.FORWARD_ICON,
          focusColor: Colors.grey,
        ),
      ),
    );
  }

  Future<void> _navigateToForum(BuildContext context) async {
    Navigator.of(context).pushNamed(ForumCategoryScreen.routeName, arguments: topicCategory);
  }
}
