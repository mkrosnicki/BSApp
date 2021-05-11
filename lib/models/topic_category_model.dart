class TopicCategoryModel {

  final String id;
  final String name;
  final String description;
  final List<TopicCategoryModel> subCategories;

  TopicCategoryModel({this.id, this.name, this.description, this.subCategories});

  static List<TopicCategoryModel> fromJsonList(List<dynamic> categoriesSnapshot) {
    final List<TopicCategoryModel> categories = [];
    for (final categorySnapshot in categoriesSnapshot) {
      categories.add(fromJson(categorySnapshot));
    }
    return categories;
  }

  static TopicCategoryModel fromJson(dynamic categorySnapshot) {
    return TopicCategoryModel(
      id: categorySnapshot['id'] as String,
      name: categorySnapshot['name'] as String,
      description: categorySnapshot['description'] as String,
      subCategories: (categorySnapshot['subCategories'] as List).map((e) => TopicCategoryModel.fromJson(e)).toList()
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TopicCategoryModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'TopicCategoryModel{id: $id, name: $name, subCategories: $subCategories}';
  }
}