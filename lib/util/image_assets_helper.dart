import 'package:BSApp/models/location_type.dart';

class ImageAssetsHelper {

  static const String assetsLocation = 'assets/images/';

  static String imageDownloadPath() {
    return '${assetsLocation}image-download-pngrepo-com.png';
  }

  static String imageUploadPath() {
    return '${assetsLocation}image-upload-pngrepo-com.png';
  }

  static String topicCategoryPath(String categoryName) {
    String retVal = '';
    if (categoryName.contains('Niedługo')) {
      retVal = '${assetsLocation}footprint-foot-pngrepo-com.png';
    }
    if (categoryName.contains('Co możecie')) {
      retVal = '${assetsLocation}diaper-pngrepo-com.png';
    }
    if (categoryName.contains('Jak sobie')) {
      retVal = '${assetsLocation}baby-pngrepo-com.png';
    }
    if (categoryName.contains('iet')) {
      retVal = '${assetsLocation}baby-feeding-eat-pngrepo-com.png';
    }
    if (categoryName.contains('Pogadajmy')) {
      retVal = '${assetsLocation}chat-pngrepo-com.png';
    }
    if (categoryName.contains('Spotkajmy')) {
      retVal = '${assetsLocation}coffee-pngrepo-com.png';
    }
    return retVal;
  }

  static String productCategoryPath(String categoryName) {
    String retVal = '';
    if (categoryName.contains('Ubranka')) {
      retVal = '${assetsLocation}pijama.png';
    }
    if (categoryName.contains('Buty')) {
      retVal = '${assetsLocation}footprint.png';
    }
    if (categoryName.contains('Pielęgnacja')) {
      retVal = '${assetsLocation}bathtub.png';
    }
    if (categoryName.contains('Karmienie')) {
      retVal = '${assetsLocation}feeding.png';
    }
    if (categoryName.contains('Wózki')) {
      retVal = '${assetsLocation}stroller.png';
    }
    if (categoryName.contains('Foteliki')) {
      retVal = '${assetsLocation}car.png';
    }
    if (categoryName.contains('Pokój')) {
      retVal = '${assetsLocation}cradle.png';
    }
    if (categoryName.contains('Moda')) {
      retVal = '${assetsLocation}dress.png';
    }
    if (categoryName.contains('Zabawki')) {
      retVal = '${assetsLocation}horse.png';
    }
    if (categoryName.contains('Inne')) {
      retVal = '${assetsLocation}pacifier.png';
    }
    return retVal;
  }

  static String validFromImagePath() {
    return '${assetsLocation}calendar1-pngrepo-com.png';
  }

  static String validToImagePath() {
    return '${assetsLocation}calendar2-pngrepo-com.png';
  }

  static String locationTypePath(LocationType locationType) {
    return locationType == LocationType.INTERNET ? internetPath() : localPath();
  }

  static String internetPath() {
    return '${assetsLocation}worldwide-planet-earth-pngrepo-com.png';
  }

  static String localPath() {
    return '${assetsLocation}placeholder-map-location-pngrepo-com.png';
  }



}