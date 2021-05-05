import 'package:BSApp/widgets/common/server_error_splash.dart';
import 'package:flutter/material.dart';

import 'loading_indicator.dart';

class ContentOrProgressIndicator extends StatelessWidget {

  final AsyncSnapshot snapshot;
  final Widget content;

  ContentOrProgressIndicator({this.snapshot, this.content});

  @override
  Widget build(BuildContext context) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: const LoadingIndicator());
    } else {
      if (snapshot.error != null) {
        return Center(
          child: const ServerErrorSplash(),
        );
      } else {
        return content;
      }
    }
  }
}
