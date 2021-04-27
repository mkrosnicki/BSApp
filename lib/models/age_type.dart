enum AgeType {
  ONE_THREE_MONTHS,
  THREE_SIX_MONTHS,
  SIX_NINE_MONTHS,
  NINE_TWELVE_MONTHS,
  ONE_TWO_YEARS,
  TWO_YEARS_AND_OLDER,
}

class AgeTypeHelper {

  static AgeType fromString(String ageTypeString) {
    for (var ageType in AgeType.values) {
      if (asString(ageType) == ageTypeString) {
        return ageType;
      }
    }
    return null;
  }

  static String asString(AgeType ageType) {
    return ageType.toString().replaceFirst('AgeType.', '');
  }

  static String asParamString(List<AgeType> ageTypes) {
    return ageTypes.map((e) => asString(e)).toList().join(",");
  }

  static String getReadable(AgeType ageType) {
    switch (ageType) {
      case AgeType.ONE_THREE_MONTHS:
        return '1 - 3 miesięce';
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

  static String getAgeValue(AgeType ageType) {
    switch (ageType) {
      case AgeType.ONE_THREE_MONTHS:
        return '0 - 3';
        break;
      case AgeType.THREE_SIX_MONTHS:
        return '3 - 6';
        break;
      case AgeType.SIX_NINE_MONTHS:
        return '6 - 9';
        break;
      case AgeType.NINE_TWELVE_MONTHS:
        return '9 - 12';
        break;
      case AgeType.ONE_TWO_YEARS:
        return '1 - 2';
        break;
      case AgeType.TWO_YEARS_AND_OLDER:
        return '2+';
        break;
      default:
        return null;
    }
  }

    static String getAgeUnit(AgeType ageType) {
      switch (ageType) {
        case AgeType.ONE_THREE_MONTHS:
          // return 'miesiące';
          return 'msc';
          break;
        case AgeType.THREE_SIX_MONTHS:
        case AgeType.SIX_NINE_MONTHS:
        case AgeType.NINE_TWELVE_MONTHS:
          // return 'miesięcy';
          return 'msc';
          break;
        case AgeType.ONE_TWO_YEARS:
          return 'lata';
          break;
        case AgeType.TWO_YEARS_AND_OLDER:
          return 'lat';
          break;
        default:
          return null;
      }
  }

}
