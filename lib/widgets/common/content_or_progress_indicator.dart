import 'package:flutter/material.dart';

class ContentOrProgressIndicator extends StatelessWidget {

  final AsyncSnapshot snapshot;
  final Widget content;

  ContentOrProgressIndicator({this.snapshot, this.content});

  @override
  Widget build(BuildContext context) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: const CircularProgressIndicator());
    } else {
      if (snapshot.error != null) {
        return Center(
          child: Text('An error occurred!'),
        );
      } else {
        return content;
      }
    }
  }
}
