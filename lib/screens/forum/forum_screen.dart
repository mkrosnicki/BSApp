import 'package:BSApp/models/adder_info_model.dart';
import 'package:BSApp/models/topic_category_model.dart';
import 'package:BSApp/models/topic_model.dart';
import 'package:BSApp/providers/topic_categories.dart';
import 'package:BSApp/util/my_icons_provider.dart';
import 'package:BSApp/util/my_styling_provider.dart';
import 'package:BSApp/widgets/bars/app_bar_bottom_border.dart';
import 'package:BSApp/widgets/bars/app_bar_button.dart';
import 'package:BSApp/widgets/bars/app_bar_close_button.dart';
import 'package:BSApp/widgets/forum/forum_category_item.dart';
import 'package:BSApp/widgets/forum/topic_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForumScreen extends StatelessWidget {
  static const routeName = '/forum';

  List<TopicCategoryModel> _allCategories;

  Future<void> _initCategories(BuildContext context) {
    if (_allCategories == null) {
      return Provider.of<TopicCategories>(context, listen: false)
          .fetchTopicCategories()
          .then((_) {
        _allCategories = Provider.of<TopicCategories>(context, listen: false)
            .topicCategories;
      });
    } else {
      return Future(() => {});
    }
  }

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
                  .map((e) => TopicItem(TopicModel(
                      id: '1',
                      addedAt: DateTime.now(),
                      title: 'Jakiś placeholder',
                      content: 'Jakiś placeholder',
                      adderInfo: AdderInfoModel(
                        id: '1',
                        username: 'fake user',
                        registeredAt: DateTime(2020),
                        addedDeals: 5,
                        addedComments: 5,
                        addedPosts: 5,
                      ))))
                  .toList(),
              ListTile(
                title: Text(
                  'Kategorie',
                  style: TextStyle(fontSize: 14),
                ),
                focusColor: Colors.grey,
              ),
              FutureBuilder(
                future: _initCategories(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    if (snapshot.error != null) {
                      return Center(
                        child: Text('An error occurred!'),
                      );
                    } else {
                      return Column(
                        children: _allCategories
                            .map((e) => ForumCategoryItem(
                                  title: e.name,
                                  description: e.description,
                                  id: e.id,
                                ))
                            .toList(),
                      );
                    }
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
