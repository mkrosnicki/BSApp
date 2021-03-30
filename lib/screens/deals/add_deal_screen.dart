import 'package:BSApp/models/add_deal_model.dart';
import 'package:BSApp/models/age_type.dart';
import 'package:BSApp/models/city_model.dart';
import 'package:BSApp/models/location_type.dart';
import 'package:BSApp/models/voivodeship_model.dart';
import 'package:BSApp/providers/deals.dart';
import 'package:BSApp/screens/common/category_selection_screen.dart';
import 'package:BSApp/screens/common/location_selection_screen.dart';
import 'package:BSApp/widgets/bars/my_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddDealScreen extends StatefulWidget {
  static const routeName = '/add-deal';

  @override
  _AddDealScreenState createState() => _AddDealScreenState();
}

class _AddDealScreenState extends State<AddDealScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _isLoading = false;

  var _newdeal = AddDealModel();
  DateTime _validFrom = DateTime.now();
  DateTime _validTo = DateTime.now();

  City _city;
  Voivodeship _voivodeship;
  bool showInternetOnly = true;

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    print(_newdeal.toString());
    Provider.of<Deals>(context, listen: false).createNewDeal(_newdeal);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dodaj nową okazje!'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text('Tytuł ogłoszenia'),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Wprowadź tytuł';
                    } else if (value.length < 5) {
                      return 'Tytuł musi mieć conajmniej 5 znaków';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    _newdeal.title = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Link do okazji'),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Wprowadź link do okazji';
                    } else if (!isUrl(value)) {
                      return 'Podany ciąg znaków nie jest adresem URL';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    _newdeal.urlLocation = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Opis'),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Wprowadź opis';
                    } else if (value.length < 10) {
                      return 'Opis powinien mieć conajmniej 10 znaków';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    _newdeal.description = value;
                  },
                ),
                ListTile(
                  title: const Text('Kategoria'),
                  subtitle: _newdeal.categories.isNotEmpty
                      ? Text(
                    categoriesString,
                    style: TextStyle(color: Colors.blue),
                  )
                      : const Text('Wszystkie kategorie'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _openCategorySelector(context),
                ),
                ListTile(
                  title: const Text('Wiek dziecka'),
                  subtitle: _newdeal.ageType == null
                      ? const Text('Dowolny')
                      : Text(
                    ageTypesString,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Wrap(
                    alignment: WrapAlignment.spaceEvenly,
                    children: _buildAgeTypeChips(),
                  ),
                ),
                Text('Lokalizacja okazji'),
                Container(
                  width: double.infinity,
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    children: _buildLocationTypeChips(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  title: const Text('Lokalizacja'),
                  subtitle: _newdeal.voivodeship != null
                      ? Text(
                    locationString,
                    style: TextStyle(color: Colors.blue),
                  )
                      : const Text('Cała Polska'),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () => _openLocationSelector(context),
                  enabled: !showInternetOnly,
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Okazja zaczyna się:'),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "${_validFrom.toLocal()}".split(' ')[0],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(
                      onPressed: () => _selectDate(context, DateType.VALID_FROM), // Refer step 3
                      child: Text(
                        'Wybierz date',
                        style:
                        TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Okazja kończy się:'),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "${_validTo.toLocal()}".split(' ')[0],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(
                      onPressed: () => _selectDate(context, DateType.VALID_TO), // Refer step 3
                      child: Text(
                        'Wybierz date',
                        style:
                        TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Regularna cena'),
                TextFormField(
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    _newdeal.regularPrice = double.parse(value);
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Aktualna cena'),
                TextFormField(
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    _newdeal.currentPrice = double.parse(value);
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Koszt dostawy'),
                TextFormField(
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    _newdeal.shippingPrice = double.parse(value);
                  },
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text('Dodaj ogłoszenie'),
                    onPressed: _submit,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: MyNavigationBar(2),
    );
  }

  String get categoriesString {
    return _newdeal.categories.map((e) => e.name).join(" / ");
  }

  String get ageTypesString {
    return AgeTypeHelper.getReadable(_newdeal.ageType);
  }


  _openCategorySelector(BuildContext context) async {
    var selectedCategories = await Navigator.of(context)
        .pushNamed(CategorySelectionScreen.routeName);
    if (selectedCategories != null) {
      setState(() {
        _newdeal.categories = selectedCategories;
      });
    }
  }

  _selectDate(BuildContext context, DateType dateType) async {
    var now = DateTime.now();
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      setState(() {
        if (dateType == DateType.VALID_TO) {
          _validTo = picked;
          _newdeal.validTo = _validTo;
        } else if (dateType == DateType.VALID_FROM) {
          _validFrom = picked;
          _newdeal.validFrom = _validFrom;
        }
      });
    }
  }

  _buildAgeTypeChips() {
    List<Widget> list = [];
    AgeType.values.forEach(
      (e) => list.add(Container(
        margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
        child: ChoiceChip(
          label: Text(AgeTypeHelper.getReadable(e)),
          selected: _newdeal.ageType == e,
          onSelected: (isSelected) {
            setState(() {
              if (isSelected) {
                _newdeal.ageType = e;
              } else {
                _newdeal.ageType = null;
              }
            });
          },
        ),
      )),
    );
    return list;
  }

  _buildLocationTypeChips() {
    List<Widget> list = LocationType.values
        .map(
          (e) => Container(
            margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
            child: ChoiceChip(
              label: Text(LocationTypeHelper.getReadable(e)),
              selected: _newdeal.locationType == e,
              onSelected: (isSelected) {
                setState(() {
                  _newdeal.locationType = e;
                  if (_newdeal.locationType == LocationType.LOCAL) {
                    showInternetOnly = false;
                  } else {
                    showInternetOnly = true;
                    _newdeal.clearLocation();
                  }
                });
              },
            ),
          ),
        )
        .toList();
    return list;
  }

  _openLocationSelector(BuildContext context) async {
    var locations = await Navigator.of(context)
        .pushNamed(LocationSelectionScreen.routeName);
    if (locations != null) {
      setState(() {
        var voivodeship = ((locations as List)[0] as Voivodeship);
        if (voivodeship != null) {
          _newdeal.voivodeship = voivodeship.id;
          _voivodeship = voivodeship;
        } else {
          _newdeal.voivodeship = null;
          _voivodeship = null;
        }
        var city = ((locations as List)[1] as City);
        if (city != null) {
          _newdeal.city = city.id;
          _city = city;
        } else {
          _newdeal.city = null;
          _city = null;
        }
      });
    }
  }

  String get locationString {
    return _voivodeship != null
        ? '${_voivodeship.name} / ${_city != null ? _city.name : 'Wszystkie miasta'}'
        : null;
  }

  bool isUrl(String value) {
    return Uri.parse(value).isAbsolute;
  }
}

enum DateType {VALID_FROM, VALID_TO}