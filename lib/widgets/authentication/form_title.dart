import 'package:flutter/material.dart';

class FormTitle extends StatelessWidget {

  final String title;

  const FormTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 18),
      ),
    );
  }
}
