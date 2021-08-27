import 'package:BSApp/util/my_styling_provider.dart';
import 'package:BSApp/widgets/bars/app_bar_add_topic_button.dart';
import 'package:BSApp/widgets/bars/app_bar_search_topic_button.dart';
import 'package:BSApp/widgets/bars/base_app_bar.dart';
import 'package:BSApp/widgets/common/decorated_tab_bar.dart';
import 'package:BSApp/widgets/common/tab_bar_factory.dart';
import 'package:BSApp/widgets/forum/forum_categories_view.dart';
import 'package:BSApp/widgets/forum/forum_my_topic_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForumScreen extends StatefulWidget {
  static const routeName = '/forum';

  @override
  _ForumScreenState createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
        _tabController.animateTo(_selectedIndex, duration: Duration.zero);
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      // initialIndex: 0,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(96.0),
          child: BaseAppBar(
            title: 'Forum',
            leading: const AppBarSearchTopicButton(),
            bottom: DecoratedTabBar(
              decoration: MyStylingProvider.DEFAULT_TAB_BAR_DECORATION,
              tabBar: TabBarFactory.withTabs(
                ['Kategorie', 'Obserwowane tematy'],
              ),
            ),
            actions: const [
              AppBarAddTopicButton(null),
            ],
          ),
        ),
        body: TabBarView(
          // controller: _tabController,
          children: [
            ForumCategoriesView(),
            ForumMyTopicsView(),
          ],
        ),
      ),
    );
  }
}
