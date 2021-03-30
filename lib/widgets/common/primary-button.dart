import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final Function function;

  const PrimaryButton(this.label, this.function);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(MyColorsProvider.BLUE),
      ),
      child: Text(
        label,
      ),
      onPressed: function,
    );
  }
}
