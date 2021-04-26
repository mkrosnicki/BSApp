import 'package:BSApp/models/comment_model.dart';
import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/providers/comments.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

import 'comment_item.dart';

class DealDetailsComments extends StatelessWidget {
  final DealModel deal;
  final PublishSubject<CommentModel> commentToReplySubject;

  DealDetailsComments(this.deal, this.commentToReplySubject);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // color: Colors.white,
          width: double.infinity,
          padding: const EdgeInsets.only(top: 12.0, bottom: 8.0, left: 6.0, right: 6.0),
          alignment: Alignment.centerLeft,
          child: const Text(
            'Komentarze',
            style: const TextStyle(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
        Container(
          width: double.infinity,
          // margin: const EdgeInsets.only(top: 5.0),
          // padding: const EdgeInsets.only(top: 5.0),
          child: FutureBuilder(
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
                      // todo nullpointer after some time?!
                      children: commentsData.mainDealComments
                          .map((comment) => CommentItem(
                              deal.id, comment, commentToReplySubject))
                          .toList(),
                    ),
                  );
                }
              }
            },
          ),
        )
      ],
    );
  }
}
