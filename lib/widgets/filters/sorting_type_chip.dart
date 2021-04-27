import 'package:BSApp/models/sorting_type.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SortingTypeChip extends StatelessWidget {
  final SortingType sortingType;
  final bool isSelected;
  final Function onClick;

  SortingTypeChip(this.sortingType, this.isSelected, this.onClick);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
        child: Column(
          children: [
            Icon(
              sortingType == SortingType.MOST_POPULAR
                  ? CupertinoIcons.graph_circle
                  : CupertinoIcons.star,
              color: isSelected ? Colors.white : MyColorsProvider.BLUE,
              size: 26,
            ),
            Text(
              sortingType == SortingType.MOST_POPULAR
                  ? 'Najpopularniejsze'
                  : 'Najnowsze',
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
