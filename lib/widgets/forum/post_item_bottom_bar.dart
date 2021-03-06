import 'package:BSApp/models/post_model.dart';
import 'package:BSApp/providers/posts.dart';
import 'package:BSApp/providers/reply_state.dart';
import 'package:BSApp/util/conjugation_helper.dart';
import 'package:BSApp/util/date_util.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class PostItemBottomBar extends StatelessWidget {
  final PostModel post;

  const PostItemBottomBar(this.post);

  @override
  Widget build(BuildContext context) {
    final int numberOfLikers = Provider.of<Posts>(context, listen: false).findById(post.id).likers.length;
    return Container(
      height: 30,
      padding: const EdgeInsets.only(),
      alignment: Alignment.centerRight,
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Wrap(
            children: [
              Text(
                DateUtil.timeAgoString(post.addedAt),
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(fontSize: 11, color: Colors.black38),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  '',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(fontSize: 11, color: Colors.black38),
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: () {
              Provider.of<ReplyState>(context, listen: false).setTopicToReply(post);
            },
            child: Text(
              'Odpowiedz',
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(fontSize: 12, color: MyColorsProvider.BLUE),
            ),
          ),
        ],
      ),
    );
  }

}
