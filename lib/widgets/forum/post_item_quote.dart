import 'package:BSApp/models/post_model.dart';
import 'package:flutter/material.dart';

class PostItemQuote extends StatelessWidget {

  final PostModel post;

  const PostItemQuote(this.post);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Container(
        width: double.infinity,
        color: Colors.yellow.shade50,
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 4.0),
              child: Wrap(
                children: [
                  Text(
                    post.repliedUsername ?? 'Usunięty użytkownik',
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(
                        fontSize: 11,
                        color: Colors.black87,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    ' napisał : ',
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(fontSize: 11, color: Colors.black87),
                  ),
                ],
              ),
            ),
            Text(
              post.quote,
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(fontSize: 11, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
