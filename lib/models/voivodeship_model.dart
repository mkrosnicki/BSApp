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
}