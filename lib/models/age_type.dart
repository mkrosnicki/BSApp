enum AgeType {
  ONE_THREE_MONTHS,
  THREE_SIX_MONTHS,
  SIX_NINE_MONTHS,
  NINE_TWELVE_MONTHS,
  ONE_TWO_YEARS,
  TWO_YEARS_AND_OLDER,
}

class AgeTypeHelper {

  static String asString(AgeType ageType) {
    return ageType.toString().replaceFirst('AgeType.', '');
  }

  static String asParamString(List<AgeType> ageTypes) {
    return ageTypes.map((e) => asString(e)).toList().join(",");
  }

  static String getReadable(AgeType ageType) {
    switch (ageType) {
      case AgeType.ONE_THREE_MONTHS:
        return '1 - 3 miesięcy';
        break;
      case AgeType.THREE_SIX_MONTHS:
        return '3 - 6 miesięcy';
        break;
      case AgeType.SIX_NINE_MONTHS:
        return '6 - 9 miesięcy';
        break;
      case AgeType.NINE_TWELVE_MONTHS:
        return '9 - 12 miesięcy';
        break;
      case AgeType.ONE_TWO_YEARS:
        return '1 - 2 lata';
        break;
      case AgeType.TWO_YEARS_AND_OLDER:
        return '2 lata i więcej';
        break;
      default:
        return null;
    }
  }

}
