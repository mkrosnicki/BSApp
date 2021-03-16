import 'package:BSApp/providers/comments.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddedCommentsScreen extends StatelessWidget {

  static const routeName = '/added-comments';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 8,
        title: Text('Dodane komentarze'),
      ),
      body: FutureBuilder(
        future: Provider.of<Comments>(context, listen: false).fetchAddedComments(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.error != null) {
              return Center(
                child: Text('An error occurred!'),
              );
            } else {
              return Consumer<Comments>(
                builder: (context, commentsData, child) =>
                    ListView.builder(
                      itemBuilder: (context, index) =>
                          Text(commentsData.addedComments[index].content),
                      itemCount: commentsData.addedComments.length,
                    ),
              );
            }
          }
        },
      ),
    );
  }
}
