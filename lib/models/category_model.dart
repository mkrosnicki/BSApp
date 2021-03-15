class CategoryModel {

  final String id;
  final String name;
  final List<CategoryModel> subCategories;

  CategoryModel({this.id, this.name, this.subCategories});

  static CategoryModel of(dynamic categorySnapshot) {
    return CategoryModel(
      id: categorySnapshot['id'],
      name: categorySnapshot['name'],
      subCategories: (categorySnapshot['subcategories'] as List).map((e) => CategoryModel.of(e)).toList()
    );
  }
}