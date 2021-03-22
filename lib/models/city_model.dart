import 'package:BSApp/models/voivodeship_model.dart';

class City {
  final String id;
  final String name;
  final int population;
  final Voivodeship voivodeship;

  City({this.id, this.name, this.population, this.voivodeship});

  static City of(dynamic citySnapshot) {
    return City(
      id: citySnapshot['id'],
      name: citySnapshot['name'],
      population: citySnapshot['population'],
      voivodeship: citySnapshot['voivodeship'],
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is City && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
