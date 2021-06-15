import 'package:flutter/material.dart';

class GreyTextButton extends StatelessWidget {
  final String label;
  final Function() function;

  const GreyTextButton(this.label, this.function);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor:
        MaterialStateProperty.all(Colors.transparent),
        padding: MaterialStateProperty.all(EdgeInsets.zero),
      ),
      onPressed: function,
      child: Text(
        label,
        style: const TextStyle(fontSize: 13, color: Colors.black54),
        textAlign: TextAlign.center,
      ),
    );
  }
}
