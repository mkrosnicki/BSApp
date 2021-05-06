enum LocationType {
  INTERNET,
  LOCAL,
}

class LocationTypeHelper {

  static String getReadable(LocationType type) {
    switch (type) {
      case LocationType.INTERNET:
        return 'Okazja w internecie';
      case LocationType.LOCAL:
        return 'Okazja stacjonarna';
      default:
        return null;
    }
  }

  static LocationType fromString(String activityTypeString) {
    for (var activityType in LocationType.values) {
      if (asString(activityType) == activityTypeString) {
        return activityType;
      }
    }
    return null;
  }

  static String asString(LocationType activityType) {
    return activityType.toString().replaceFirst('LocationType.', '');
  }
}