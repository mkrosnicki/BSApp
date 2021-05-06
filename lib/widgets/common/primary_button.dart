import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final Function() function;
  final double fontSize;

  const PrimaryButton(this.label, this.function, {this.fontSize});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(MyColorsProvider.BLUE),
      ),
      onPressed: function,
      child: Text(
        label,
        style: TextStyle(fontSize: fontSize),
      ),
    );
  }
}
