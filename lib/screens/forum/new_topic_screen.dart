import 'package:BSApp/models/post_model.dart';
import 'package:BSApp/providers/topics.dart';
import 'package:BSApp/util/my_styling_provider.dart';
import 'package:BSApp/widgets/bars/app_bar_back_button.dart';
import 'package:BSApp/widgets/bars/app_bar_bottom_border.dart';
import 'package:BSApp/widgets/bars/app_bar_close_button.dart';
import 'package:BSApp/widgets/bars/base_app_bar.dart';
import 'package:BSApp/widgets/forum/topic_screen_input_bar.dart';
import 'package:BSApp/widgets/forum/topic_screen_posts.dart';
import 'package:BSApp/widgets/forum/topic_screen_topic_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class NewTopicScreen extends StatelessWidget {
  static const routeName = '/new-topic';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Nowy temat',
        leading: const AppBarCloseButton(Colors.black),
      ),
      body: Center(
        child: Text('Nowy temat'),
      ),
    );
  }

}
