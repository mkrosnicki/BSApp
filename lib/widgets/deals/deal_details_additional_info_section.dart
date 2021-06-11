import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/util/date_util.dart';
import 'package:BSApp/util/image_assets_helper.dart';
import 'package:flutter/material.dart';

import 'deal_details_info_tile.dart';

class DealDetailsAdditionalInfoSection extends StatelessWidget {
  final DealModel dealModel;

  const DealDetailsAdditionalInfoSection(this.dealModel);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 14.0, bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 4.0),
            child: const Text(
              'Informacje',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Flex(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              direction: Axis.horizontal,
              children: [
                Flexible(
                  child: DealDetailsInfoTile(
                      'Kategoria',
                      dealModel.categories[0],
                      ImageAssetsHelper.productCategoryPath(
                          dealModel.categories[0])),
                ),
                Flexible(
                  child: DealDetailsInfoTile(
                      'Lokalizacja',
                      dealModel.locationString,
                      ImageAssetsHelper.locationTypePath(
                          dealModel.locationType)),
                ),
              ],
            ),
          ),
          Flex(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            direction: Axis.horizontal,
            children: [
              if (dealModel.startDate != null)
                Flexible(
                  child: DealDetailsInfoTile(
                      'Ważna od:',
                      DateUtil.getFormatted(dealModel.startDate),
                      ImageAssetsHelper.validFromImagePath()),
                ),
              if (dealModel.endDate != null)
                Flexible(
                  child: DealDetailsInfoTile(
                      'Ważna do:',
                      DateUtil.getFormatted(dealModel.endDate),
                      ImageAssetsHelper.validToImagePath()),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
