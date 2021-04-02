import 'package:BSApp/providers/topics.dart';
import 'package:BSApp/util/my_styling_provider.dart';
import 'package:BSApp/widgets/bars/app_bar_back_button.dart';
import 'package:BSApp/widgets/bars/app_bar_bottom_border.dart';
import 'package:BSApp/widgets/bars/app_bar_close_button.dart';
import 'package:BSApp/widgets/forum/topic_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForumCategoryScreen extends StatelessWidget {
  static const routeName = '/forum-category';

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
        child: FutureBuilder(
          future: Provider.of<Topics>(context, listen: false).fetchTopics(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.error != null) {
                return Center(
                  child: Text('An error occurred!'),
                );
              } else {
                return Consumer<Topics>(
                  builder: (context, topicsData, child) => ListView.builder(
                    itemBuilder: (context, index) => TopicItem(
                        title: topicsData.topics[index].title,
                        function: () {}),
                    itemCount: topicsData.topics.length,
                  ),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
