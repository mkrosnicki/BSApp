import 'package:BSApp/providers/comments.dart';
import 'package:BSApp/widgets/bars/app_bar_back_button.dart';
import 'package:BSApp/widgets/bars/base_app_bar.dart';
import 'package:BSApp/widgets/comments/added_comment_item.dart';
import 'package:BSApp/widgets/common/server_error_splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddedCommentsScreen extends StatelessWidget {
  static const routeName = '/added-comments';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        leading: const AppBarBackButton(Colors.black),
        title: 'Dodane komentarze',
      ),
      body: FutureBuilder(
        future:
            Provider.of<Comments>(context, listen: false).fetchAddedComments(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.error != null) {
              return Center(
                child: const ServerErrorSplash(),
              );
            } else {
              return Consumer<Comments>(
                builder: (context, commentsData, child) => ListView.builder(
                  itemBuilder: (context, index) =>
                      AddedCommentItem(commentsData.allAddedComments[index]),
                  itemCount: commentsData.allAddedComments.length,
                ),
              );
            }
          }
        },
      ),
    );
  }
}
