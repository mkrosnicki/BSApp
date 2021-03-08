import 'package:BSApp/providers/deals.dart';

class DealTypeMapper {

  static DealType of(String dealType) {
    switch(dealType) {
      case 'COUPON':
        return DealType.COUPON;
        break;
      case 'OCCASION':
        return DealType.OCCASION;
        break;
      default:
        throw Exception('Not known deal type!');
    }
  }

}