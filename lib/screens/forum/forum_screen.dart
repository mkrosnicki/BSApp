import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/util/my_styling_provider.dart';
import 'package:BSApp/widgets/bars/app_bar_add_topic_button.dart';
import 'package:BSApp/widgets/bars/app_bar_search_topic_button.dart';
import 'package:BSApp/widgets/bars/base_app_bar.dart';
import 'package:BSApp/widgets/common/colored_tab.dart';
import 'package:BSApp/widgets/common/decorated_tab_bar.dart';
import 'package:BSApp/widgets/forum/forum_categories_view.dart';
import 'package:BSApp/widgets/forum/forum_my_topic_view.dart';
import 'package:flutter/material.dart';

class ForumScreen extends StatefulWidget {
  static const routeName = '/forum';

  @override
  _ForumScreenState createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80.0),
          child: BaseAppBar(
            title: 'Forum',
            leading: const AppBarSearchTopicButton(),
            bottom: DecoratedTabBar(
              tabBar: TabBar(
                labelPadding: EdgeInsets.zero,
                indicatorColor: MyColorsProvider.PASTEL_LIGHT_BLUE,
                labelColor: Colors.white,
                labelStyle: MyStylingProvider.SELECTED_TAB_TEXT_STYLE,
                unselectedLabelStyle: MyStylingProvider.UNSELECTED_TAB_TEXT_STYLE,
                onTap: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                tabs: [
                  ColoredTab('Kategorie', _selectedIndex == 0),
                  ColoredTab('Obserwowane tematy', _selectedIndex == 1),
                ],
              ),
            ),
            actions: const [
              AppBarAddTopicButton(null),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ForumCategoriesView(),
            ForumMyTopicsView(),
          ],
        ),
      ),
    );
  }
}
