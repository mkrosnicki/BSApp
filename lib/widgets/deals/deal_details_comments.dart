import 'package:BSApp/models/comment_model.dart';
import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/providers/comments.dart';
import 'package:BSApp/providers/deal_reply_state.dart';
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
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.only(
        top: 5.0,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5.0, bottom: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Komentarze',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  ),
                  GestureDetector(
                    onTap: () {
                      commentToReplySubject.add(CommentModel()); // todo
                      Provider.of<DealReplyState>(context, listen: false)
                          .startDealReply();
                    },
                    child: const Text(
                      'Napisz komentarz',
                      style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 13,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ),
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
                        children: commentsData.mainDealComments
                            .map((comment) => CommentItem(deal.id, comment, commentToReplySubject))
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
    );
  }
}
