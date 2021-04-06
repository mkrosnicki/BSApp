import 'package:BSApp/models/topic_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopicScreenPosts extends StatelessWidget {

  final TopicModel topic;

  TopicScreenPosts(this.topic);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
        child: Column(
          children: [
            Padding(
              padding:
              const EdgeInsets.only(top: 5.0, bottom: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Komentarze',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () => Provider.of<DealReplyState>(context, listen: false).startDealReply(),
                    child: Text(
                      'Napisz komentarz',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
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
                            .map((comment) => CommentItem(deal.id, comment))
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