import 'dart:io';

import 'package:BSApp/models/add_deal_model.dart';
import 'package:BSApp/models/custom_exception.dart';
import 'package:BSApp/models/deal_type.dart';
import 'package:BSApp/models/location_type.dart';
import 'package:BSApp/providers/deals.dart';
import 'package:BSApp/screens/common/category_selection_screen.dart';
import 'package:BSApp/util/my_styling_provider.dart';
import 'package:BSApp/widgets/common/information_dialog.dart';
import 'package:BSApp/widgets/common/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'age_type_chips.dart';
import 'deal_date.dart';
import 'localisation_selector.dart';

class OccasionForm extends StatefulWidget {
  final AddDealModel newDeal;

  const OccasionForm(this.newDeal);

  @override
  _OccasionFormState createState() => _OccasionFormState();
}

class _OccasionFormState extends State<OccasionForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _isLoading = false;
  AddDealModel _newDeal;

  @override
  void initState() {
    super.initState();
    _newDeal = widget.newDeal;
    _showInternetOnly = _newDeal.locationType == LocationType.INTERNET;
  }

  bool _showInternetOnly;

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _newDeal.dealType = DealType.OCCASION;
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<Deals>(context, listen: false).createNewDeal(_newDeal);
      _newDeal.reset();
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

  Future<void> _takePicture() async {
    final imageFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (imageFile == null) {
      return;
    }
    setState(() {
      _newDeal.image = File(imageFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: const LoadingIndicator(),
          )
        : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: _takePicture,
                      child: Container(
                        width: double.infinity,
                        height: 120,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey)),
                        child: _newDeal.image != null
                            ? Image.file(
                          _newDeal.image,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        )
                            : Text(
                          'Dodaj obrazek',
                          textAlign: TextAlign.center,
                        ),
                        alignment: Alignment.center,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      initialValue: _newDeal.title,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Wprowadź tytuł';
                        } else if (value.length < 5) {
                          return 'Tytuł musi mieć co najmniej 5 znaków';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        _newDeal.title = value;
                      },
                      decoration: MyStylingProvider.TEXT_FIELD_DECORATION.copyWith(helperText: 'Tytuł ogłoszenia'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      initialValue: _newDeal.description,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Wprowadź opis';
                        } else if (value.length < 10) {
                          return 'Opis powinien mieć conajmniej 10 znaków';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        _newDeal.description = value;
                      },
                      decoration: MyStylingProvider.TEXT_FIELD_DECORATION.copyWith(helperText: 'Opis'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      initialValue: _newDeal.urlLocation,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Wprowadź link do okazji';
                        } else if (!_isUrl(value)) {
                          return 'Podany ciąg znaków nie jest adresem URL';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        _newDeal.urlLocation = value;
                      },
                      decoration: MyStylingProvider.TEXT_FIELD_DECORATION.copyWith(helperText: 'Link do okazji'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Okazja internetowa'),
                        Switch.adaptive(
                            value:
                                _newDeal.locationType == LocationType.INTERNET,
                            onChanged: (value) {
                              _changeLocation(value);
                            }),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (!_showInternetOnly)
                      ListTile(
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
                    if (!_showInternetOnly)
                      Column(
                        children: [
                          TextFormField(
                            initialValue: _newDeal.locationDescription,
                            enabled: !_showInternetOnly,
                            onChanged: (value) {
                              _newDeal.locationDescription = value;
                            },
                            decoration: MyStylingProvider.TEXT_FIELD_DECORATION.copyWith(helperText: 'Opis lokalizacji'),
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
                    const Text('Wiek dziecka'),
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
                      decoration: MyStylingProvider.TEXT_FIELD_DECORATION.copyWith(helperText: 'Regularna cena'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
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
                      decoration: MyStylingProvider.TEXT_FIELD_DECORATION.copyWith(helperText: 'Aktualna cena'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
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
                      decoration: MyStylingProvider.TEXT_FIELD_DECORATION.copyWith(helperText: 'Koszt dostawy'),
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
    FocusScope.of(context).unfocus();
    await DealDateSelector.selectDateFor(_newDeal, context, dateType);
    setState(() {});
  }

  String get categoriesString {
    return _newDeal.categories.map((e) => e.name).join(" / ");
  }

  _openCategorySelector(BuildContext context) async {
    FocusScope.of(context).unfocus();
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
        _newDeal.clearLocation();
      } else {
        _newDeal.locationType = LocationType.LOCAL;
      }
    });
  }

  _openLocationSelector() async {
    FocusScope.of(context).unfocus();
    await openLocationSelector(context, _newDeal);
    setState(() {});
  }

  bool _isUrl(String value) {
    return Uri.parse(value).isAbsolute;
  }
}
