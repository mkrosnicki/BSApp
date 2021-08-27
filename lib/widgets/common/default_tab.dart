import 'package:flutter/material.dart';

class DefaultTab extends StatelessWidget {

  final String tabText;

  const DefaultTab(this.tabText);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 14.0, top: 14.0),
      alignment: Alignment.center,
      color: Colors.white,
      child: Text(
        tabText,
        style: const TextStyle(letterSpacing: 0.2, fontFamily: 'InterUI'),
      ),
      // width: double.infinity,
    );
  }
}
