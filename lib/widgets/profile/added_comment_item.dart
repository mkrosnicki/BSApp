import 'package:BSApp/models/comment_model.dart';
import 'package:flutter/material.dart';

class AddedCommentItem extends StatelessWidget {
  final CommentModel comment;

  AddedCommentItem(this.comment);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2.0),
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          Wrap(
            children: [
              Text(
                'Komentarz dodany do okazji',
                style: const TextStyle(fontSize: 11),
              ),
              Text(
                '${comment.adderInfo.username}',
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                    fontSize: 12,
                    color: Colors.blue,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 0.0),
            child: Container(
              width: double.infinity,
              color: Colors.yellow.shade50,
              margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 0.0),
                    child: Wrap(
                      children: [
                        Text(
                          comment.content,
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                              fontSize: 12,
                              color: Colors.black87,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          ' napisał : ',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .copyWith(fontSize: 12, color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    comment.content,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(fontSize: 12, color: Colors.black87),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
