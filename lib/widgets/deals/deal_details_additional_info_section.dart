import 'package:BSApp/models/category_model.dart';
import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/util/date_util.dart';
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
        Flex(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          direction: Axis.horizontal,
          children: [
            Flexible(
              child: DealDetailsInfoTile(
                  'Kategoria',
                  dealModel.categories[0],
                  CategoryModelHelper.imagePathForCategoryName(
                      dealModel.categories[0])),
            ),
            Flexible(
              child: DealDetailsInfoTile('Lokalizacja',
                  dealModel.locationString, 'assets/images/car.png'),
            ),
          ],
        ),
        Flex(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          direction: Axis.horizontal,
          children: [
            Flexible(
              child: DealDetailsInfoTile(
                  'Ważna od:', DateUtil.getFormatted(dealModel.startDate), 'assets/images/car.png'),
            ),
            Flexible(
              child: DealDetailsInfoTile(
                  'Ważna do:', DateUtil.getFormatted(dealModel.endDate), 'assets/images/car.png'),
            ),
          ],
        ),
        // Wrap(
        //   children: [
        //     DealDetailsInfoTile(
        //         'Kategoria',
        //         dealModel.categories[0],
        //         CategoryModelHelper.imagePathForCategoryName(
        //             dealModel.categories[0])),
        //     DealDetailsInfoTile('Lokalizacja', dealModel.locationString,
        //         'assets/images/car.png'),
        //     const DealDetailsInfoTile(
        //         'Ważna od:', '12.02.2012', 'assets/images/car.png'),
        //     const DealDetailsInfoTile(
        //         'Ważna do:', '12.02.2012', 'assets/images/car.png'),
        //   ],
        // ),
      ],
    );
  }
}
