import 'package:BSApp/widgets/common/server_error_splash.dart';
import 'package:flutter/material.dart';

import 'loading_indicator.dart';

class ContentOrProgressIndicator extends StatelessWidget {

  final AsyncSnapshot snapshot;
  final Widget content;

  const ContentOrProgressIndicator({this.snapshot, this.content});

  @override
  Widget build(BuildContext context) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: LoadingIndicator());
    } else {
      if (snapshot.error != null) {
        return const Center(
          child: ServerErrorSplash(),
        );
      } else {
        return content;
      }
    }
  }
}
