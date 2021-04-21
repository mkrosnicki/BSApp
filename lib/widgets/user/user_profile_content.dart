import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'file:///D:/Projects/Flutter/BSApp/lib/widgets/user/user_profile_added_deals.dart';

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
        return UserProfileAddedDeals(userId);
      },
    );
  }
}
