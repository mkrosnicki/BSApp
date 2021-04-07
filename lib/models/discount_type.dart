enum DiscountType {
  PERCENTAGE,
  ABSOLUTE,
}

class DiscountTypeHelper {

  static String asString(DiscountType discountType) {
    return discountType.toString().replaceFirst('DiscountType.', '');
  }
}