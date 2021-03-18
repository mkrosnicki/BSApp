enum SortingType {

  NEWEST,
  MOST_POPULAR

}

class SortingTypeHelper {

  static String asString(SortingType sortingType) {
    return sortingType.toString().replaceFirst('SortingType.', '');
  }

  static String getReadable(SortingType sortingType) {
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

}