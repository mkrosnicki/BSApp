import 'package:BSApp/models/deal_model.dart';
import 'package:flutter/material.dart';

class CommentAddedActivityContent extends StatelessWidget {
  final String username;
  final String dealTitle;

  const CommentAddedActivityContent(this.username, this.dealTitle);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Flex(
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$username skomentował(a) okazję',
            style: const TextStyle(fontSize: 12, color: Colors.black54, height: 1.2),
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              dealTitle,
              style:
              const TextStyle(
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
