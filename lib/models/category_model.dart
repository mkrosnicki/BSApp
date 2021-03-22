class CategoryModel {

  final String id;
  final String name;
  final List<CategoryModel> subCategories;

  CategoryModel({this.id, this.name, this.subCategories});

  static CategoryModel of(dynamic categorySnapshot) {
    return CategoryModel(
      id: categorySnapshot['id'],
      name: categorySnapshot['name'],
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
}