import 'package:BSApp/models/voivodeship_model.dart';

class City {
  final String id;
  final String name;
  final int population;

  City({this.id, this.name, this.population});

  static City of(dynamic citySnapshot) {
    return City(
      id: citySnapshot['id'],
      name: citySnapshot['name'],
      population: citySnapshot['population'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'population': population,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is City && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
