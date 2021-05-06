import 'package:BSApp/models/add_deal_model.dart';
import 'package:BSApp/models/age_type.dart';
import 'package:BSApp/widgets/filters/age_type_chip.dart';
import 'package:flutter/material.dart';

class AgeTypeChips extends StatefulWidget {
  final AddDealModel dealModel;

  const AgeTypeChips(this.dealModel);

  @override
  _AgeTypeChipsState createState() => _AgeTypeChipsState();
}

class _AgeTypeChipsState extends State<AgeTypeChips> {
  @override
  Widget build(BuildContext context) {
    final deal = widget.dealModel;
    final List<Widget> list = [];
    AgeType.values.forEach(
      (e) => list.add(AgeTypeChip(e, deal.ageTypes.contains(e), () {
        setState(() {
          if (!deal.ageTypes.contains(e)) {
            deal.ageTypes.add(e);
          } else {
            deal.ageTypes.remove(e);
          }
        });
      })),
    );
    return Wrap(
      alignment: WrapAlignment.spaceEvenly,
      children: list,
    );
  }
}
