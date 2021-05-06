import 'package:BSApp/models/add_deal_model.dart';
import 'package:flutter/material.dart';

enum DealDateType { VALID_FROM, VALID_TO }

class DealDateSelector {

  static Future selectDateFor(
    AddDealModel deal,
    BuildContext context,
    DealDateType dateType,
  ) async {
    final initialDate = _getInitialDate(deal, dateType);

    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
        if (dateType == DealDateType.VALID_TO) {
          deal.validTo = picked;
        } else if (dateType == DealDateType.VALID_FROM) {
          deal.validFrom = picked;
        }
    }
    return Future.value();
  }

  static DateTime _getInitialDate(AddDealModel deal, DealDateType dateType) {
    DateTime initialDate;
    if (dateType == DealDateType.VALID_TO) {
      initialDate = deal.validTo;
    } else if (dateType == DealDateType.VALID_FROM) {
      initialDate = deal.validFrom;
    }
    return initialDate;
  }
}
