import 'package:BSApp/models/post_model.dart';
import 'package:BSApp/util/conjugation_helper.dart';
import 'package:BSApp/util/date_util.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class PostItemBottomBar extends StatelessWidget {
  final PostModel post;
  final PublishSubject<PostModel> postToReplySubject;

  const PostItemBottomBar(this.post, this.postToReplySubject);

  @override
  Widget build(BuildContext context) {
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
              Text(
                '${post.likers.length} ${ConjugationHelper.likesConjugation(post.likers.length)}',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(fontSize: 11, color: Colors.black38),
              ),
            ],
          ),
          TextButton(
            onPressed: () {
              postToReplySubject.add(post);
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
