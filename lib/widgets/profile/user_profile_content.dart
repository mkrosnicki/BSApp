import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class UserProfileContent extends StatelessWidget {

  final PublishSubject<int> contentIdSubject;
  Stream<int> get _contentIdStream => contentIdSubject.stream;

  UserProfileContent(this.contentIdSubject);

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
              child: Text(contentId.toString()),
            )
          ],
        );
      }
    );
  }
}
