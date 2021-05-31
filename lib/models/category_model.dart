class CategoryModel {

  final String id;
  final String name;
  final String description;
  final List<CategoryModel> subCategories;

  CategoryModel({this.id, this.name, this.description, this.subCategories});

  static CategoryModel fromJson(dynamic categorySnapshot) {
    return CategoryModel(
      id: categorySnapshot['id'],
      name: categorySnapshot['name'],
      description: categorySnapshot['description'],
      subCategories: (categorySnapshot['subCategories'] as List).map((e) => CategoryModel.fromJson(e)).toList()
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'subCategories': subCategories.map((e) => e.toJson()).toList(),
    };
  }


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'CategoryModel{id: $id, name: $name, description: $description, subCategories: $subCategories}';
  }
}

class CategoryModelHelper {
  
  static const String assetsLocation = 'assets/images/';
  

  static String imagePathForCategory(CategoryModel category) {
    return imagePathForCategoryName(category.name);
  }

  static String imagePathForCategoryName(String categoryName) {
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
}