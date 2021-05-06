import 'package:BSApp/models/comment_model.dart';
import 'package:BSApp/util/date_util.dart';
import 'package:BSApp/util/fake_data_provider.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/widgets/common/user_avatar.dart';
import 'package:flutter/material.dart';

class AddedCommentItem extends StatelessWidget {
  final CommentModel comment;

  const AddedCommentItem(this.comment);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2.0),
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 6.0),
      width: double.infinity,
      color: Colors.white,
      child: Flex(
        direction: Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: UserAvatar(
              username: comment.adderInfo.username,
              imagePath: FakeDataProvider.USER_AVATAR_PATH,
              radius: 20,
              backgroundColor: MyColorsProvider.BLUE,
            ),
          ),
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Flex(
                direction: Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    text: TextSpan(
                      text:
                          '${comment.adderInfo.username} dodał(a) komentarz pod okazją: ',
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                            fontSize: 11,
                            color: Colors.black,
                            height: 1.3,
                          ),
                      children: [
                        const TextSpan(
                          text: 'jakaś tam okazja',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    alignment: Alignment.topLeft,
                    child: Text(
                      comment.content,
                      style: const TextStyle(
                          fontSize: 11, color: Colors.black54, height: 1.3),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            alignment: Alignment.topRight,
            child: Text(
              DateUtil.timeAgoString(comment.addedAt),
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(fontSize: 11, color: Colors.black38),
            ),
          ),
        ],
      ),
    );
  }
}
