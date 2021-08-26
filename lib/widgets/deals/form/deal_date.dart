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
    final theOtherDate = _getTheOtherDate(deal, dateType);

    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
      selectableDayPredicate: (date) {
        if (theOtherDate == null) {
          return true;
        } else if (dateType == DealDateType.VALID_FROM) {
          return date.isBefore(theOtherDate) || date.isAtSameMomentAs(theOtherDate);
        } else if (dateType == DealDateType.VALID_TO) {
          return date.isAfter(theOtherDate) || date.isAtSameMomentAs(theOtherDate);
        } else {
          return true;
        }
      },
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

  static DateTime _getTheOtherDate(AddDealModel deal, DealDateType dateType) {
    DateTime theOtherDate;
    if (dateType == DealDateType.VALID_TO) {
      theOtherDate = deal.validFrom;
    } else if (dateType == DealDateType.VALID_FROM) {
      theOtherDate = deal.validTo;
    }
    return theOtherDate;
  }

  static DateTime _getInitialDate(AddDealModel deal, DealDateType dateType) {
    DateTime initialDate;
    if (dateType == DealDateType.VALID_TO) {
      initialDate = deal.validTo;
    } else if (dateType == DealDateType.VALID_FROM) {
      initialDate = deal.validFrom;
    }
    return initialDate ?? DateTime.now().toUtc();
  }
}
