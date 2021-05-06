import 'package:BSApp/models/add_deal_model.dart';
import 'package:BSApp/models/city_model.dart';
import 'package:BSApp/models/voivodeship_model.dart';
import 'package:BSApp/screens/common/location_selection_screen.dart';
import 'package:flutter/material.dart';

Future<void> openLocationSelector(BuildContext context, AddDealModel dealModel) async {
  final locations = await Navigator.of(context)
      .pushNamed(LocationSelectionScreen.routeName);
  if (locations != null) {
      final voivodeship = (locations as List)[0] as Voivodeship;
      if (voivodeship != null) {
        dealModel.voivodeship = voivodeship.id;
        dealModel.voivodeshipReadable = voivodeship.name;
      } else {
        dealModel.voivodeship = null;
        dealModel.voivodeshipReadable = null;
      }
      final city = (locations as List)[1] as City;
      if (city != null) {
        dealModel.city = city.id;
        dealModel.cityReadable = city.name;
      } else {
        dealModel.city = null;
        dealModel.cityReadable = null;
      }
  }
}

String locationString(AddDealModel dealModel) {
  return dealModel.voivodeship != null
      ? '${dealModel.voivodeshipReadable} / ${dealModel.city != null ? dealModel.cityReadable : 'Wszystkie miasta'}'
      : null;
}