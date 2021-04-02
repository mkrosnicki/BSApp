enum DealType {
  COUPON,
  OCCASION,
}

class DealTypeHelper {

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

  static String asString(DealType dealType) {
    return dealType.toString().replaceFirst('DealType.', '');
  }
}