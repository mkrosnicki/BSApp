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
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 35.0),
        child: Container(
          width: 48.0,
          margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 0.0),
          padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
          child: Column(
            children: [
              Text(
                AgeTypeHelper.getAgeValue(ageType),
                style: TextStyle(
                  fontSize: 13,
                  height: 1.6,
                  // fontWeight: FontWeight.w600,
                  // color: isSelected ? Colors.white : MyColorsProvider.BLUE,
                  color: isSelected ? MyColorsProvider.DEEP_BLUE : Colors.black38,
                ),
              ),
              Text(
                AgeTypeHelper.getAgeUnit(ageType),
                style: TextStyle(
                  fontSize: 12,
                  height: 1.6,
                  color: isSelected ? MyColorsProvider.DEEP_BLUE : Colors.black38,
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: isSelected ? MyColorsProvider.DEEP_BLUE : Colors.black12,
              width: 0.8,
            ),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
        ),
      ),
    );
  }
}
