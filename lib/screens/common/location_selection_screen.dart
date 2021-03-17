import 'package:BSApp/models/city_model.dart';
import 'package:BSApp/models/voivodeship_model.dart';
import 'package:BSApp/providers/locations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocationSelectionScreen extends StatefulWidget {
  static const routeName = '/location-selection';

  @override
  _LocationSelectionScreenState createState() =>
      _LocationSelectionScreenState();
}

class _LocationSelectionScreenState extends State<LocationSelectionScreen> {
  List<Voivodeship> _allVoivodeships;
  Voivodeship _selectedVoivodeship;
  List<City> _selectedCities = [];

  Future<void> _initCategories() {
    if (_allVoivodeships == null) {
      return Provider.of<Locations>(context, listen: false).fetchVoivodeships().then((_) {
        _allVoivodeships = Provider.of<Locations>(context, listen: false).voivodeships;
      });
    } else {
      return Future(() => {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _selectedVoivodeship == null
          ? FutureBuilder(
              future: _initCategories(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  if (snapshot.error != null) {
                    return Center(
                      child: Text('An error occurred!'),
                    );
                  } else {
                    return _buildVoivodeshipsList(_allVoivodeships);
                  }
                }
              },
            )
          : _buildCitiesList(_selectedVoivodeship.cities),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: Text('Wybierz miejsce'),
      automaticallyImplyLeading: false,
      leading: FlatButton(
        onPressed: () => _goUp(),
        child: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
      actions: [
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop(null);
          },
          child: Icon(
            Icons.clear,
            color: Colors.white,
          ),
        )
      ],
    );
  }

  _buildCitiesList(List<City> cities) {
    return Column(
      children: [
        if (_selectedCities.isNotEmpty) ListTile(
          title: Text('${_selectedCities.elementAt(_selectedCities.length - 1).name}'),
          focusColor: Colors.grey,
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) => FlatButton(
              child: ListTile(
                title: Text(cities[index].name),
                // trailing: cities[index].cities.isEmpty ? Icon(null) : Icon(Icons.chevron_right),
                focusColor: Colors.grey,
              ),
              onPressed: () => _selectCity(cities[index]),
            ),
            itemCount: cities.length,
          ),
        ),
      ],
    );
  }


  _buildVoivodeshipsList(List<Voivodeship> voivodeships) {
    return Column(
      children: [
        if (_selectedCities.isNotEmpty) ListTile(
          title: Text('${_selectedCities.elementAt(_selectedCities.length - 1).name}'),
          focusColor: Colors.grey,
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) => FlatButton(
              child: ListTile(
                title: Text(voivodeships[index].name),
                subtitle: Text('${voivodeships[index].cities.length}'),
                trailing: voivodeships[index].cities.isEmpty ? Icon(null) : Icon(Icons.chevron_right),
                focusColor: Colors.grey,
              ),
              onPressed: () => _selectVoivodeship(voivodeships[index]),
            ),
            itemCount: voivodeships.length,
          ),
        ),
      ],
    );
  }

  String _getCategoriesSuffix(int numOfCategories) {
    int lastDigit = numOfCategories % 10;
    if (numOfCategories == 1) {
      return 'kategoria';
    } else if (numOfCategories >= 11 && numOfCategories <= 14) {
      return 'kategorii';
    } else if (lastDigit == 2 || lastDigit == 3 || lastDigit == 4) {
      return 'kategorie';
    } else {
      return 'kategorii';
    }
  }

  _selectVoivodeship(Voivodeship voivodeship) {
    setState(() {
      _selectedVoivodeship = voivodeship;
    });
  }

  _goUp() {
    if (_selectedCities.isEmpty) {
      Navigator.of(context).pop(null);
    } else {
      setState(() {
        _selectedCities.removeLast();
      });
    }
  }

  _selectCity(City city) {
    _selectedCities.add(city);
  }
}
