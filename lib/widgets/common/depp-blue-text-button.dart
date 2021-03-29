import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/material.dart';

class DeepBlueTextButton extends StatelessWidget {
  final String label;
  final Function function;

  DeepBlueTextButton(this.label, this.function);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white),
        elevation: MaterialStateProperty.all(0.0),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: MyColorsProvider.DEEP_BLUE,
        ),
      ),
      onPressed: function,
    );
  }
}
