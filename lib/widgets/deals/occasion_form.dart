import 'package:BSApp/models/add_deal_model.dart';
import 'package:BSApp/models/age_type.dart';
import 'package:BSApp/models/custom_exception.dart';
import 'package:BSApp/models/deal_type.dart';
import 'package:BSApp/models/location_type.dart';
import 'package:BSApp/providers/deals.dart';
import 'package:BSApp/screens/common/category_selection_screen.dart';
import 'package:BSApp/widgets/common/information_dialog.dart';
import 'package:BSApp/widgets/deals/age_type_chips.dart';
import 'package:BSApp/widgets/deals/localisation_selector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'deal_date.dart';

class OccasionForm extends StatefulWidget {
  final AddDealModel newDeal;

  const OccasionForm(this.newDeal);

  @override
  _OccasionFormState createState() => _OccasionFormState();
}

class _OccasionFormState extends State<OccasionForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _isLoading = false;
  var _locationDescriptionController = TextEditingController();
  AddDealModel _newDeal;

  @override
  void initState() {
    super.initState();
    _newDeal = widget.newDeal;
    _newDeal.dealType = DealType.OCCASION;
    _showInternetOnly = _newDeal.locationType == LocationType.INTERNET;
  }

  bool _showInternetOnly;

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    print(_newDeal.toString());
    try {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<Deals>(context, listen: false).createNewDeal(_newDeal);
      setState(() {
        _isLoading = false;
      });
      await showInformationDialog(
        context,
        Text('Sukces!'),
        Text('Ogłoszenie zostało dodane'),
        Text('Ok'),
      );
      // Navigator.of(context).pushReplacementNamed(DealsScreen.routeName);
    } on CustomException catch (error) {
      var errorMessage = 'Coś poszło nie tak. Spróbuj później!';
      if (error.toString().contains('Unauthorized')) {
        errorMessage = 'W celu dodania ogłoszenia zaloguj się!';
      }
      await showInformationDialog(
        context,
        Text('Błąd podczas dodawania ogłoszenia'),
        Text(errorMessage),
        Text('Ok'),
      );
    } catch (error) {
      const errorMessage = 'Coś poszło nie tak. Spróbuj później!';
      await showInformationDialog(
        context,
        Text('Błąd podczas dodawania ogłoszenia'),
        Text(errorMessage),
        Text('Ok'),
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Okazja internetowa'),
                        Switch.adaptive(
                            value: _newDeal.locationType == LocationType.INTERNET, onChanged: (value) {
                              _changeLocation(value);
                        }),
                      ],
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
                    if (!_showInternetOnly) ListTile(
                      title: const Text('Lokalizacja'),
                      subtitle: _newDeal.voivodeship != null
                          ? Text(
                              locationString(_newDeal),
                              style: TextStyle(color: Colors.blue),
                            )
                          : const Text('Cała Polska'),
                      trailing: Icon(Icons.chevron_right),
                      onTap: () => _openLocationSelector(),
                      enabled: !_showInternetOnly,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (!_showInternetOnly) Column(
                      children: [
                        Text('Opis lokalizacji'),
                        TextFormField(
                          controller: _locationDescriptionController,
                          enabled: !_showInternetOnly,
                          onSaved: (value) {
                            _newDeal.locationDescription = value;
                          },
                        ),
                      ],
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
                      child: AgeTypeChips(_newDeal),
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
                          onPressed: () => _selectDate(DealDateType.VALID_FROM),
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
                          onPressed: () => _selectDate(DealDateType.VALID_TO),
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
          );
  }

  void _selectDate(DealDateType dateType) async {
    await DealDateSelector.selectDateFor(_newDeal, context, dateType);
    setState(() {});
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

  void _changeLocation(bool value) {
    setState(() {
      _showInternetOnly = value;
      if (_showInternetOnly) {
        _newDeal.locationType = LocationType.INTERNET;
        _locationDescriptionController.clear();
        _newDeal.clearLocation();
      } else {
        _newDeal.locationType = LocationType.LOCAL;
      }
    });
  }

  _openLocationSelector() async {
    await openLocationSelector(context, _newDeal);
    setState(() {});
  }

  bool _isUrl(String value) {
    return Uri.parse(value).isAbsolute;
  }
}
