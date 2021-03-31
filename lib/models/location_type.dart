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
    }
  }
}