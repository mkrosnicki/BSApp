import 'package:BSApp/models/add_deal_model.dart';
import 'package:BSApp/models/age_type.dart';
import 'package:flutter/material.dart';

class AgeTypeChips extends StatefulWidget {
  final AddDealModel dealModel;

  AgeTypeChips(this.dealModel);

  @override
  _AgeTypeChipsState createState() => _AgeTypeChipsState();
}

class _AgeTypeChipsState extends State<AgeTypeChips> {
  @override
  Widget build(BuildContext context) {
    var deal = widget.dealModel;
    List<Widget> list = [];
    AgeType.values.forEach(
      (e) => list.add(Container(
        margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
        child: ChoiceChip(
          label: Text(AgeTypeHelper.getReadable(e)),
          selected: deal.ageTypes.contains(e),
          onSelected: (isSelected) {
            setState(() {
              if (isSelected) {
                deal.ageTypes.add(e);
              } else {
                deal.ageTypes.remove(e);
              }
            });
          },
        ),
      )),
    );
    return Wrap(
      alignment: WrapAlignment.spaceEvenly,
      children: list,
    );
  }
}
