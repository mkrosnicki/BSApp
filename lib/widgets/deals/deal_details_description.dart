import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/util/date_util.dart';
import 'package:BSApp/widgets/deals/deal_details_additional_info_section.dart';
import 'package:BSApp/widgets/deals/deal_details_deal_code_section.dart';
import 'package:BSApp/widgets/deals/deal_details_description_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'deal_details_title_price_section.dart';

class DealDetailsDescription extends StatelessWidget {
  static const statNameStyle = TextStyle(fontSize: 11, color: Colors.grey);
  static const activeMenuItemStyle =
      TextStyle(fontSize: 11, color: Colors.black);

  final DealModel deal;

  const DealDetailsDescription(this.deal);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DealDetailsTitlePriceSection(deal),
          DealDetailsAdditionalInfoSection(deal),
          DealDetailsDealCodeSection(deal.code),
          DealDetailsDescriptionSection(deal.description)
        ],
      ),
    );
  }
}
