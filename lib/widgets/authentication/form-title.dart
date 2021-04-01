import 'package:flutter/material.dart';

class FormTitle extends StatelessWidget {

  final String title;

  FormTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return                     Container(
      padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 12.0),
      child: Text(
        title,
        style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 18),
      ),
    );
  }
}
