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
    String categoryId = ModalRoute.of(context).settings.arguments as String;
    print(categoryId);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tematy',
          style: MyStylingProvider.TEXT_BLACK,
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        bottom: const AppBarBottomBorder(),
        leading: const AppBarBackButton(Colors.black),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: Provider.of<Topics>(context, listen: false).fetchCategoryTopics(categoryId),
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
                    itemBuilder: (context, index) => TopicItem(topicsData.categoryTopics[index]),
                    itemCount: topicsData.categoryTopics.length,
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
