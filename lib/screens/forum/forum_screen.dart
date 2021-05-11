import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/widgets/bars/base_app_bar.dart';
import 'package:BSApp/widgets/forum/forum_categories_view.dart';
import 'package:flutter/material.dart';

class ForumScreen extends StatefulWidget {
  static const routeName = '/forum';

  @override
  _ForumScreenState createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: BaseAppBar(
            title: 'Forum',
            bottom: TabBar(
              labelPadding: EdgeInsets.all(10.0),
              indicatorColor: MyColorsProvider.BLUE,
              labelColor: Colors.black,
              labelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
              unselectedLabelStyle:
                  TextStyle(color: Colors.black, fontSize: 12),
              tabs: [
                Text('Kategorie'),
                Text('Moje tematy'),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            ForumCategoriesView(),
            const Text('2'),
          ],
        ),
      ),
    );
  }
}
