import 'package:BSApp/models/category_model.dart';
import 'package:BSApp/models/deal_model.dart';
import 'package:flutter/material.dart';

import 'deal_details_info_tile.dart';

class DealDetailsAdditionalInfoSection extends StatelessWidget {

  final DealModel dealModel;

  const DealDetailsAdditionalInfoSection(this.dealModel);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 16.0, bottom: 14.0),
          child: const Text(
            'Dodatkowe informacje',
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
        Wrap(
          direction: Axis.horizontal,
          children: [
            DealDetailsInfoTile(
                'Kategoria', dealModel.categories[0], CategoryModelHelper.imagePathForCategoryName(dealModel.categories[0])),
            const DealDetailsInfoTile(
                'Ważna od:', '12.02.2012', 'assets/images/car.png'),
            const DealDetailsInfoTile(
                'Kategoria', 'Bodziaki', 'assets/images/car.png'),
          ],
        ),
      ],
    );
  }
}
