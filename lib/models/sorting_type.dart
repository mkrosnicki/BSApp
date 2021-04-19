enum SortingType {

  NEWEST,
  MOST_POPULAR

}

class SortingTypeHelper {

  static String asString(SortingType sortingType) {
    return sortingType.toString().replaceFirst('SortingType.', '');
  }

  static SortingType fromString(String sortingTypeString) {
    for (var sortingType in SortingType.values) {
      if (asString(sortingType) == sortingTypeString) {
        return sortingType;
      }
    }
    return null;
  }

  static String getReadableM(SortingType sortingType) {
    switch (sortingType) {
      case SortingType.NEWEST:
        return 'Najnowsze';
        break;
      case SortingType.MOST_POPULAR:
        return 'Najpopularniejsze';
        break;
      default:
        return null;
    }
  }

  static String getReadableC(SortingType sortingType) {
    switch (sortingType) {
      case SortingType.NEWEST:
        return 'Sortuj po najnowszych';
        break;
      case SortingType.MOST_POPULAR:
        return 'Sortuj po najpopularniejszych';
        break;
      default:
        return null;
    }
  }

}