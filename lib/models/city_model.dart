import 'package:BSApp/models/voivodeship_model.dart';

class City {

  final String name;
  final int population;
  final Voivodeship voivodeship;

  City({this.name, this.population, this.voivodeship});

  static City of(dynamic citySnapshot) {
    return City(
        name: citySnapshot['name'],
        population: citySnapshot['population'],
        voivodeship: citySnapshot['voivodeship'],
    );
  }
}