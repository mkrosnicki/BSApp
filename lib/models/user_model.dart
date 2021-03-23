class UserModel {
  final String id;
  final String username;
  final DateTime registeredAt;

  UserModel({this.id, this.username, this.registeredAt});

  static UserModel of(dynamic citySnapshot) {
    return UserModel(
      id: citySnapshot['id'],
      username: citySnapshot['username'],
      registeredAt: DateTime.parse(citySnapshot['registeredAt']),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
