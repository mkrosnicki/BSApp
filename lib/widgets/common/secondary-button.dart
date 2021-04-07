import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final String label;
  final Function function;
  final double fontSize;

  const SecondaryButton(this.label, this.function, {this.fontSize});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0.0),
        backgroundColor: MaterialStateProperty.all(Colors.white),
      ),
      child: Text(
        label,
        style: TextStyle(color: MyColorsProvider.BLUE, fontSize: fontSize),
      ),
      onPressed: function,
    );
  }
}
