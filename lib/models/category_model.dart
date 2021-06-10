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