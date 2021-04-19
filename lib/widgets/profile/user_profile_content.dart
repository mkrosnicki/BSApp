import 'package:BSApp/widgets/profile/user_profile_added_deals.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class UserProfileContent extends StatelessWidget {

  final PublishSubject<int> contentIdSubject;
  final String userId;
  Stream<int> get _contentIdStream => contentIdSubject.stream;

  UserProfileContent(this.userId, this.contentIdSubject);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: _contentIdStream,
      builder: (context, AsyncSnapshot<int> snapshot) {
        final int contentId = snapshot.data != null ? snapshot.data : 1;
        return Flex(
          direction: Axis.vertical,
          children: [
            Center(
              child: UserProfileAddedDeals(userId),
            )
          ],
        );
      }
    );
  }
}
