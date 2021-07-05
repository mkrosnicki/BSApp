import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/material.dart';

class ColoredTab extends StatelessWidget {

  final String label;
  final bool isSelected;

  const ColoredTab(this.label, this.isSelected);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isSelected ? MyColorsProvider.PASTEL_BLUE : MyColorsProvider.PASTEL_LIGHT_BLUE,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      alignment: Alignment.center,
      child: Text(label),
    );
  }
}
