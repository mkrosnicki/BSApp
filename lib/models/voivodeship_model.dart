import 'city_model.dart';

class Voivodeship {

  final String id;
  final String name;
  final List<City> cities;

  Voivodeship({this.id, this.name, this.cities});

  static Voivodeship of(dynamic voivodeshipSnapshot) {
    return Voivodeship(
        id: voivodeshipSnapshot['id'],
        name: voivodeshipSnapshot['name'],
        cities: (voivodeshipSnapshot['cities'] as List).map((e) => City.of(e)).toList()
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'cities': cities.map((e) => e.toJson()).toList(),
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Voivodeship &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}