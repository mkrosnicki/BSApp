import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/providers/comments.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'comment_item.dart';

class DealDetailsComments extends StatelessWidget {

  final DealModel deal;
  final Function setCommentModeFunction;

  DealDetailsComments(this.deal, this.setCommentModeFunction);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
      child: Container(
        color: Color.fromRGBO(249, 250, 251, 1),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
          child: Column(
            children: [
              FutureBuilder(
                future: Provider.of<Comments>(context, listen: false)
                    .fetchCommentsForDeal(deal.id),
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
                        builder: (context, commentsData, child) => Column(
                          children: commentsData.dealComments
                              .map((comment) => CommentItem(comment, setCommentModeFunction))
                              .toList(),
                        ),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
