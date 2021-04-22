import 'package:flutter/material.dart';

class TopicItemBottomBar extends StatelessWidget {

  final int numberOfPosts;

  TopicItemBottomBar(this.numberOfPosts);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            '${numberOfPosts} postów',
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(fontSize: 11, color: Colors.black38),
          ),
          // Text(
          //   ' • ',
          //   style: Theme.of(context)
          //       .textTheme
          //       .bodyText2
          //       .copyWith(fontSize: 11, color: Colors.black38),
          // ),
          // Text(
          //   '10 odpowiedzi',
          //   style: Theme.of(context)
          //       .textTheme
          //       .bodyText2
          //       .copyWith(fontSize: 11, color: Colors.black38),
          // ),
        ],
      ),
    );
  }
}
