class TopicCategoryModel {

  final String id;
  final String name;
  final String description;
  final List<TopicCategoryModel> subCategories;

  TopicCategoryModel({this.id, this.name, this.description, this.subCategories});

  static TopicCategoryModel of(dynamic categorySnapshot) {
    return TopicCategoryModel(
      id: categorySnapshot['id'],
      name: categorySnapshot['name'],
      description: categorySnapshot['description'],
      subCategories: (categorySnapshot['subCategories'] as List).map((e) => TopicCategoryModel.of(e)).toList()
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