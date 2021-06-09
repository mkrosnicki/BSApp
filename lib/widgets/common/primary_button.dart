import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final Function() function;
  final double fontSize;

  const PrimaryButton(this.label, this.function, {this.fontSize});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: MyColorsProvider.BLUE,
      textColor: Colors.white,
      disabledColor: MyColorsProvider.LIGHT_GRAY,
      onPressed: function,
      child: Text(
        label,
        style: TextStyle(fontSize: fontSize),
      ),
    );
  }
}
