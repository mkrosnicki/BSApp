import 'package:BSApp/models/add_deal_model.dart';
import 'package:BSApp/models/age_type.dart';
import 'package:BSApp/models/city_model.dart';
import 'package:BSApp/models/custom_exception.dart';
import 'package:BSApp/models/location_type.dart';
import 'package:BSApp/models/voivodeship_model.dart';
import 'package:BSApp/providers/deals.dart';
import 'package:BSApp/screens/common/category_selection_screen.dart';
import 'package:BSApp/screens/common/location_selection_screen.dart';
import 'package:BSApp/screens/deals/deals_screen.dart';
import 'package:BSApp/widgets/bars/app_bar_add_deal.dart';
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
  var _locationDescriptionController = TextEditingController();

  var _newDeal = AddDealModel();

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
    try {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<Deals>(context, listen: false).createNewDeal(_newDeal);
      setState(() {
        _isLoading = false;
      });
      await _showInformationDialog('Sukces!', 'Ogłoszenie zostało dodane');
      Navigator.of(context).pushReplacementNamed(DealsScreen.routeName);
    } on CustomException catch (error) {
      var errorMessage = 'Coś poszło nie tak. Spróbuj później!';
      if (error.toString().contains('Unauthorized')) {
        errorMessage = 'W celu dodania ogłoszenia zaloguj się!';
      }
      await _showInformationDialog(
          'Błąd podczas dodawania ogłoszenia', errorMessage);
    } catch (error) {
      const errorMessage = 'Coś poszło nie tak. Spróbuj później!';
      await _showInformationDialog(
          'Błąd podczas dodawania ogłoszenia', errorMessage);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _newDeal.locationType = LocationType.INTERNET;
    _newDeal.validFrom = DateTime.now();
    _newDeal.validTo = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarAddDeal(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
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
                          _newDeal.title = value;
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
                          _newDeal.description = value;
                        },
                      ),
                      SizedBox(
                        height: 10,
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
                      Text('Link do okazji'),
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Wprowadź link do okazji';
                          } else if (!_isUrl(value)) {
                            return 'Podany ciąg znaków nie jest adresem URL';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          _newDeal.urlLocation = value;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        title: const Text('Lokalizacja'),
                        subtitle: _newDeal.voivodeship != null
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
                      Text('Opis lokalizacji'),
                      TextFormField(
                        controller: _locationDescriptionController,
                        enabled: !showInternetOnly,
                        onSaved: (value) {
                          _newDeal.locationDescription = value;
                        },
                      ),
                      ListTile(
                        title: const Text('Kategoria'),
                        subtitle: _newDeal.categories.isNotEmpty
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
                        subtitle: _newDeal.ageTypes.isEmpty
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
                      SizedBox(
                        height: 10,
                      ),
                      Text('Okazja zaczyna się:'),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            "${_newDeal.validFrom.toLocal()}".split(' ')[0],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          ElevatedButton(
                            onPressed: () =>
                                _selectDate(context, DateType.VALID_FROM),
                            // Refer step 3
                            child: Text(
                              'Wybierz date',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
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
                            "${_newDeal.validTo.toLocal()}".split(' ')[0],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          ElevatedButton(
                            onPressed: () =>
                                _selectDate(context, DateType.VALID_TO),
                            // Refer step 3
                            child: Text(
                              'Wybierz date',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Regularna cena'),
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Wprowadź kwotę";
                          } else if (double.parse(value) < 0) {
                            return "Kwota nie może być ujemna";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.number,
                        onSaved: (value) {
                          _newDeal.regularPrice = double.parse(value);
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Aktualna cena'),
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Wprowadź kwotę";
                          } else if (double.parse(value) < 0) {
                            return "Kwota nie może być ujemna";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.number,
                        onSaved: (value) {
                          _newDeal.currentPrice = double.parse(value);
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Koszt dostawy'),
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Wprowadź kwotę";
                          } else if (double.parse(value) < 0) {
                            return "Kwota nie może być ujemna";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.number,
                        onSaved: (value) {
                          _newDeal.shippingPrice = double.parse(value);
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
    );
  }

  String get categoriesString {
    return _newDeal.categories.map((e) => e.name).join(" / ");
  }

  String get ageTypesString {
    return _newDeal.ageTypes
        .map((e) => AgeTypeHelper.getReadable(e))
        .join(", ");
  }

  _openCategorySelector(BuildContext context) async {
    var selectedCategories = await Navigator.of(context)
        .pushNamed(CategorySelectionScreen.routeName);
    if (selectedCategories != null) {
      setState(() {
        _newDeal.categories = selectedCategories;
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
          _newDeal.validTo = picked;
        } else if (dateType == DateType.VALID_FROM) {
          _newDeal.validFrom = picked;
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
          selected: _newDeal.ageTypes.contains(e),
          onSelected: (isSelected) {
            setState(() {
              if (isSelected) {
                _newDeal.ageTypes.add(e);
              } else {
                _newDeal.ageTypes.remove(e);
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
              selected: _newDeal.locationType == e,
              onSelected: (isSelected) {
                setState(() {
                  _newDeal.locationType = e;
                  if (_newDeal.locationType == LocationType.LOCAL) {
                    showInternetOnly = false;
                    _locationDescriptionController.clear();
                  } else {
                    showInternetOnly = true;
                    _newDeal.clearLocation();
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
          _newDeal.voivodeship = voivodeship.id;
          _voivodeship = voivodeship;
        } else {
          _newDeal.voivodeship = null;
          _voivodeship = null;
        }
        var city = ((locations as List)[1] as City);
        if (city != null) {
          _newDeal.city = city.id;
          _city = city;
        } else {
          _newDeal.city = null;
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

  bool _isUrl(String value) {
    return Uri.parse(value).isAbsolute;
  }

  Future<void> _showInformationDialog(String title, String message) async {
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }
}

enum DateType { VALID_FROM, VALID_TO }
