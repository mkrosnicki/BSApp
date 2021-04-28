import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/models/post_model.dart';
import 'package:flutter/material.dart';

class PostAddedActivityContent extends StatelessWidget {
  final String username;
  final PostModel post;

  PostAddedActivityContent(this.username, this.post);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            '$username wypowiedział(a) się w temacie',
            style: TextStyle(fontSize: 12, color: Colors.black54, height: 1.2),
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              post.content,
              style:
              TextStyle(
                fontSize: 12,
                height: 1.5,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
