import 'package:BSApp/models/age_type.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AgeTypeChip extends StatelessWidget {
  final AgeType ageType;
  final bool isSelected;
  final Function onClick;

  AgeTypeChip(this.ageType, this.isSelected, this.onClick);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 0.0),
        padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        child: Column(
          children: [
            Text(
              AgeTypeHelper.getAgeValue(ageType),
              style: TextStyle(
                fontSize: 14,
                height: 1.6,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : MyColorsProvider.BLUE,
              ),
            ),
            Text(
              AgeTypeHelper.getAgeUnit(ageType),
              style: TextStyle(
                fontSize: 12,
                height: 1.6,
                color: isSelected ? Colors.white : MyColorsProvider.BLUE,
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: isSelected ? MyColorsProvider.BLUE : Colors.white,
          border: Border.all(color: MyColorsProvider.BLUE, width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
      ),
    );
  }
}
