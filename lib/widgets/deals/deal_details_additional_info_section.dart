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
            const DealDetailsInfoTile(
                'Lokalizacja', '12.02.2012', 'assets/images/car.png'),
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
