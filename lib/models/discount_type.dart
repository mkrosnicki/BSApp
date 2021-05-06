enum DiscountType {
  PERCENTAGE,
  ABSOLUTE,
}

class DiscountTypeHelper {

  static String asString(DiscountType discountType) {
    return discountType.toString().replaceFirst('DiscountType.', '');
  }

  static String getReadable(DiscountType type) {
    switch (type) {
      case DiscountType.ABSOLUTE:
        return ' zł';
        break;
      case DiscountType.PERCENTAGE:
        return '%';
        break;
      default:
        return null;
    }
  }

  static DiscountType fromString(String discountTypeString) {
    for (var activityType in DiscountType.values) {
      if (asString(activityType) == discountTypeString) {
        return activityType;
      }
    }
    return null;
  }
}