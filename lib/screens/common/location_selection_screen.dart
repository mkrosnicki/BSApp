import 'package:BSApp/models/city_model.dart';
import 'package:BSApp/models/voivodeship_model.dart';
import 'package:BSApp/providers/locations.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/util/my_icons_provider.dart';
import 'package:BSApp/widgets/bars/app_bar_button.dart';
import 'package:BSApp/widgets/bars/app_bar_close_button.dart';
import 'package:BSApp/widgets/bars/base_app_bar.dart';
import 'package:BSApp/widgets/common/loading_indicator.dart';
import 'package:BSApp/widgets/common/server_error_splash.dart';
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
      return Provider.of<Locations>(context, listen: false)
          .fetchVoivodeships()
          .then((_) {
        _allVoivodeships =
            Provider.of<Locations>(context, listen: false).voivodeships;
      });
    } else {
      return Future(() => {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BaseAppBar(
        title: 'Lokalizacja',
        leading: AppBarButton(
          onPress: () => _goUp(),
          icon: MyIconsProvider.BACK_WHITE_ICON,
        ),
        actions: const [
          AppBarCloseButton(Colors.white),
        ],
      ),
      body: _selectedVoivodeship == null
          ? FutureBuilder(
              future: _initCategories(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: LoadingIndicator());
                } else {
                  if (snapshot.error != null) {
                    return const Center(
                      child: ServerErrorSplash(),
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

 Widget _buildCitiesList(List<City> cities) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              if (index == 0) {
                return FlatButton(
                  onPressed: _selectAllCitiesInVoivodeship,
                  shape: const Border(
                    bottom: BorderSide(color: MyColorsProvider.GREY_BORDER_COLOR, width: 0.5),
                  ),
                  child: ListTile(
                    title: Text(
                      'Ca??e wojew??dztwo ${_selectedVoivodeship.name}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    focusColor: Colors.grey,
                  ),
                );
              } else {
                return FlatButton(
                  onPressed: () => _selectCity(cities[index - 1]),
                  shape: const Border(
                    bottom: BorderSide(color: MyColorsProvider.GREY_BORDER_COLOR, width: 0.5),
                  ),
                  child: ListTile(
                    title: Text(
                      cities[index - 1].name,
                      style: const TextStyle(fontSize: 14),
                    ),
                    focusColor: Colors.grey,
                  ),
                );
              }
            },
            itemCount: cities.length + 1,
          ),
        ),
      ],
    );
  }

  Widget _buildVoivodeshipsList(List<Voivodeship> voivodeships) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) => FlatButton(
              onPressed: () => _selectVoivodeship(voivodeships[index]),
              shape: const Border(
                bottom: BorderSide(color: MyColorsProvider.GREY_BORDER_COLOR, width: 0.5),
              ),
              child: ListTile(
                title: Text(
                  voivodeships[index].name,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                subtitle: Text(
                  '${voivodeships[index].cities.length} ${_getCitiesSuffix(voivodeships[index].cities.length)}',
                  style: const TextStyle(
                    fontSize: 13,
                  ),
                ),
                trailing: voivodeships[index].cities.isEmpty
                    ? MyIconsProvider.NONE
                    : MyIconsProvider.FORWARD_ICON,
                focusColor: Colors.grey,
              ),
            ),
            itemCount: voivodeships.length,
          ),
        ),
      ],
    );
  }

  String _getCitiesSuffix(int numOfCities) {
    final int lastDigit = numOfCities % 10;
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
