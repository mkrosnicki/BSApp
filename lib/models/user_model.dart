class UserModel {
  final String id;
  final String username;
  final DateTime registeredAt;

  UserModel({this.id, this.username, this.registeredAt});

  static UserModel of(dynamic userSnapshot) {
    return UserModel(
      id: userSnapshot['id'],
      username: userSnapshot['username'],
      registeredAt: DateTime.parse(userSnapshot['registeredAt']),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'UserModel{id: $id, username: $username, registeredAt: $registeredAt}';
  }
}
