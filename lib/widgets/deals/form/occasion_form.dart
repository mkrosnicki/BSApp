import 'dart:io';

import 'package:BSApp/models/add_deal_model.dart';
import 'package:BSApp/models/custom_exception.dart';
import 'package:BSApp/models/deal_type.dart';
import 'package:BSApp/models/location_type.dart';
import 'package:BSApp/providers/deals.dart';
import 'package:BSApp/screens/common/category_selection_screen.dart';
import 'package:BSApp/util/my_colors_provider.dart';
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
        const Text('Sukces!'),
        const Text('Ogłoszenie zostało dodane'),
        const Text('Ok'),
      );
      // Navigator.of(context).pushReplacementNamed(DealsScreen.routeName);
    } on CustomException catch (error) {
      var errorMessage = 'Coś poszło nie tak. Spróbuj później!';
      if (error.toString().contains('Unauthorized')) {
        errorMessage = 'W celu dodania ogłoszenia zaloguj się!';
      }
      await showInformationDialog(
        context,
        const Text('Błąd podczas dodawania ogłoszenia'),
        Text(errorMessage),
        const Text('Ok'),
      );
    } catch (error) {
      const errorMessage = 'Coś poszło nie tak. Spróbuj później!';
      await showInformationDialog(
        context,
        const Text('Błąd podczas dodawania ogłoszenia'),
        const Text(errorMessage),
        const Text('Ok'),
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
        ? const Center(
            child: LoadingIndicator(),
          )
        : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: _takePicture,
                      child: Container(
                        width: double.infinity,
                        height: 120,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey)),
                        alignment: Alignment.center,
                        child: _newDeal.image != null
                            ? Image.file(
                                _newDeal.image,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              )
                            : const Text(
                                'Dodaj obrazek',
                                textAlign: TextAlign.center,
                              ),
                      ),
                    ),
                    const SizedBox(
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
                      decoration: MyStylingProvider
                          .textFormFiledDecorationWithLabelText(
                              'Tytuł ogłoszenia'),
                    ),
                    const SizedBox(
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
                      decoration: MyStylingProvider
                          .textFormFiledDecorationWithLabelText('Opis'),
                    ),
                    const SizedBox(
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
                      decoration: MyStylingProvider
                          .textFormFiledDecorationWithLabelText(
                              'Link do okazji'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Okazja internetowa'),
                          Switch.adaptive(
                              activeColor: MyColorsProvider.BLUE,
                              value: _newDeal.locationType ==
                                  LocationType.INTERNET,
                              onChanged: (value) {
                                _changeLocation(value);
                              }),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (!_showInternetOnly)
                      ListTile(
                        title: const Text('Lokalizacja'),
                        subtitle: _newDeal.voivodeship != null
                            ? Text(
                                locationString(_newDeal),
                                style: const TextStyle(color: Colors.blue),
                              )
                            : const Text('Cała Polska'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => _openLocationSelector(),
                        enabled: !_showInternetOnly,
                      ),
                    const SizedBox(
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
                            decoration: MyStylingProvider
                                .textFormFiledDecorationWithLabelText(
                                    'Opis lokalizacji'),
                          ),
                        ],
                      ),
                    ListTile(
                      title: const Text('Kategoria'),
                      subtitle: _newDeal.categories.isNotEmpty
                          ? Text(
                              categoriesString,
                              style: const TextStyle(color: Colors.blue),
                            )
                          : const Text('Wszystkie kategorie'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => _openCategorySelector(context),
                    ),
                    Container(
                        margin: const EdgeInsets.only(
                          left: 16,
                        ),
                        child: const Text('Wiek dziecka')),
                    SizedBox(
                      width: double.infinity,
                      child: AgeTypeChips(_newDeal),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () => _selectDate(DealDateType.VALID_FROM),
                          color: MyColorsProvider.BLUE,
                        ),
                        const Text('Okazja zaczyna się: '),
                        Text(
                          "${_newDeal.validFrom.toLocal()}".split(' ')[0],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () => _selectDate(DealDateType.VALID_TO),
                          color: MyColorsProvider.BLUE,
                        ),
                        const Text('Okazja kończy się: '),
                        Text(
                          "${_newDeal.validTo.toLocal()}".split(' ')[0],
                        ),
                      ],
                    ),
                    const SizedBox(
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
                      decoration: MyStylingProvider
                          .textFormFiledDecorationWithLabelText(
                              'Regularna cena'),
                    ),
                    const SizedBox(
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
                      decoration: MyStylingProvider
                          .textFormFiledDecorationWithLabelText(
                              'Aktualna cena'),
                    ),
                    const SizedBox(
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
                      decoration: MyStylingProvider
                          .textFormFiledDecorationWithLabelText(
                              'Koszt dostawy'),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: _submit,
                        child: const Text(
                          'Dodaj ogłoszenie',
                          style: MyStylingProvider.TEXT_BLACK,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  Future<void> _selectDate(DealDateType dateType) async {
    FocusScope.of(context).unfocus();
    await DealDateSelector.selectDateFor(_newDeal, context, dateType);
    setState(() {});
  }

  String get categoriesString {
    return _newDeal.categories.map((e) => e.name).join(" / ");
  }

  Future<void> _openCategorySelector(BuildContext context) async {
    FocusScope.of(context).unfocus();
    final selectedCategories = await Navigator.of(context)
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

  Future<void> _openLocationSelector() async {
    FocusScope.of(context).unfocus();
    await openLocationSelector(context, _newDeal);
    setState(() {});
  }

  bool _isUrl(String value) {
    return Uri.parse(value).isAbsolute;
  }
}
