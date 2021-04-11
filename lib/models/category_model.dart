class CategoryModel {

  final String id;
  final String name;
  final String description;
  final List<CategoryModel> subCategories;

  CategoryModel({this.id, this.name, this.description, this.subCategories});

  static CategoryModel of(dynamic categorySnapshot) {
    return CategoryModel(
      id: categorySnapshot['id'],
      name: categorySnapshot['name'],
      description: categorySnapshot['description'],
      subCategories: (categorySnapshot['subCategories'] as List).map((e) => CategoryModel.of(e)).toList()
    );
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

  static String assetNameFor(CategoryModel category) {
    if (category.name.contains('Ubranka')) {
      return 'pijama.png';
    }
    if (category.name.contains('Buty')) {
      return 'footprint.png';
    }
    if (category.name.contains('Pielęgnacja')) {
      return 'bathtub.png';
    }
    if (category.name.contains('Karmienie')) {
      return 'feeding.png';
    }
    if (category.name.contains('Wózki')) {
      return 'stroller.png';
    }
    if (category.name.contains('Foteliki')) {
      return 'car.png';
    }
    if (category.name.contains('Pokój')) {
      return 'cradle.png';
    }
    if (category.name.contains('Moda')) {
      return 'dress.png';
    }
    if (category.name.contains('Zabawki')) {
      return 'horse.png';
    }
    if (category.name.contains('Inne')) {
      return 'pacifier.png';
    }
  }


}