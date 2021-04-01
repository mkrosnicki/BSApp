import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/material.dart';

class GreyTextButton extends StatelessWidget {
  final String label;
  final Function function;

  GreyTextButton(this.label, this.function);

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
        style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w400,
            fontSize: 13),
        textAlign: TextAlign.center,
      ),
    );
  }
}
