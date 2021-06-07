import 'package:flutter/material.dart';

class FormFieldTitle extends StatelessWidget {

  final String title;

  const FormFieldTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 13, color: Colors.black54),
      ),
    );
  }
}
