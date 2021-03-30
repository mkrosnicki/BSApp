import 'package:BSApp/models/city_model.dart';
import 'package:BSApp/models/voivodeship_model.dart';
import 'package:BSApp/providers/locations.dart';
import 'package:BSApp/util/my_icons_provider.dart';
import 'package:BSApp/util/my_styling_provider.dart';
import 'package:BSApp/widgets/bars/app_bar_bottom_border.dart';
import 'package:BSApp/widgets/bars/app_bar_button.dart';
import 'package:BSApp/widgets/bars/app_bar_close_button.dart';
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
  City _selectedCity;

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Lokalizacja', style: MyStylingProvider.TEXT_BLACK,),
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        bottom: const AppBarBottomBorder(),
        leading: AppBarButton(
          onPress: () => _goUp(),
          icon: MyIconsProvider.BACK_BLACK_ICON,
        ),
        actions: [
          AppBarCloseButton(Colors.black),
        ],
      ),
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

  _buildCitiesList(List<City> cities) {
    return Column(
      children: [
        FlatButton(
          child: ListTile(
            title: Text('Całe województwo ${_selectedVoivodeship.name}'),
            focusColor: Colors.grey,
          ),
          onPressed: _selectAllCitiesInVoivodeship,
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) => FlatButton(
              child: ListTile(
                title: Text(cities[index].name),
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
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) => FlatButton(
              child: ListTile(
                title: Text(voivodeships[index].name),
                subtitle: Text('${voivodeships[index].cities.length} ${_getCitiesSuffix(voivodeships[index].cities.length)}'),
                trailing: voivodeships[index].cities.isEmpty ? MyIconsProvider.NONE : MyIconsProvider.FORWARD_ICON,
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

  String _getCitiesSuffix(int numOfCities) {
    int lastDigit = numOfCities % 10;
    if (numOfCities == 1) {
      return 'miasto';
    } else if (lastDigit == 2 || lastDigit == 3 || lastDigit == 4) {
      return 'miasta';
    } else {
      return 'miast';
    }
  }

  _selectVoivodeship(Voivodeship voivodeship) {
    setState(() {
      _selectedVoivodeship = voivodeship;
    });
  }

  _goUp() {
    if (_selectedVoivodeship != null) {
      setState(() {
        _selectedVoivodeship = null;
      });
    } else {
      Navigator.of(context).pop([null, null]);
    }
  }

  _selectAllCitiesInVoivodeship() {
    _selectCity(null);
  }

  _selectCity(City city) {
    Navigator.of(context).pop([_selectedVoivodeship, city]);
  }
}
