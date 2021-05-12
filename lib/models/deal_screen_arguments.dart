import 'package:BSApp/models/deal_model.dart';

class DealScreenArguments {
  final DealModel deal;
  final String commentToScrollId;

  DealScreenArguments(this.deal, {this.commentToScrollId});
}
