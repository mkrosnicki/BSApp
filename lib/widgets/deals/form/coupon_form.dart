import 'package:BSApp/models/add_deal_model.dart';
import 'package:BSApp/models/custom_exception.dart';
import 'package:BSApp/models/deal_type.dart';
import 'package:BSApp/models/discount_type.dart';
import 'package:BSApp/models/location_type.dart';
import 'package:BSApp/providers/deals.dart';
import 'package:BSApp/screens/common/category_selection_screen.dart';
import 'package:BSApp/widgets/common/information_dialog.dart';
import 'package:BSApp/widgets/deals/form/localisation_selector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'age_type_chips.dart';
import 'deal_date.dart';

class CouponForm extends StatefulWidget {
  final AddDealModel newDeal;

  const CouponForm(this.newDeal);

  @override
  _CouponFormState createState() => _CouponFormState();
}

class _CouponFormState extends State<CouponForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _isLoading = false;
  AddDealModel _newDeal;

  @override
  void initState() {
    super.initState();
    _newDeal = widget.newDeal;
    _showInternetOnly = _newDeal.locationType == LocationType.INTERNET;
    _newDeal.discountType = DiscountType.PERCENTAGE;
  }

  bool _showInternetOnly;

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _newDeal.dealType = DealType.COUPON;
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
        Text('Kupon zostało dodany'),
        Text('Ok'),
      );
      // Navigator.of(context).pushReplacementNamed(DealsScreen.routeName);
    } on CustomException catch (error) {
      var errorMessage = 'Coś poszło nie tak. Spróbuj później!';
      if (error.toString().contains('Unauthorized')) {
        errorMessage = 'W celu dodania kuponu zaloguj się!';
      }
      await showInformationDialog(
        context,
        Text('Błąd podczas dodawania kuponu'),
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
                    Text('Tytuł kuponu'),
                    TextFormField(
                      initialValue: _newDeal.title,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Wprowadź tytuł';
                        } else if (value.length < 5) {
                          return 'Tytuł musi mieć conajmniej 5 znaków';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        _newDeal.title = value;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Opis'),
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
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Kod kuponu'),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Wprowadź kod kuponu';
                        } else if (value.length < 3) {
                          return 'Kod powinien mieć co najmniej 3 znaki.';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        _newDeal.dealCode = value;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Kupon internetowy'),
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
                    Text('Link do kuponu'),
                    TextFormField(
                      initialValue: _newDeal.urlLocation,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Wprowadź link do kuponu';
                        } else if (!_isUrl(value)) {
                          return 'Podany ciąg znaków nie jest adresem URL';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        _newDeal.urlLocation = value;
                      },
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
                          Text('Opis lokalizacji'),
                          TextFormField(
                            initialValue: _newDeal.locationDescription,
                            enabled: !_showInternetOnly,
                            onChanged: (value) {
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
                    const Text('Wiek dziecka'),
                    Container(
                      width: double.infinity,
                      child: AgeTypeChips(_newDeal),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Kupon ważny od:'),
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
                    Text('Kupon ważny do:'),
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
                    Text('Wartość kuponu'),
                    Row(
                      children: [
                        Flexible(
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Wprowadź wartość";
                              } else if (double.parse(value) < 0) {
                                return "Wartość nie może być ujemna";
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.number,
                            onSaved: (value) {
                              _newDeal.discountValue = double.parse(value);
                            },
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              if (_newDeal.discountType == DiscountType.ABSOLUTE) {
                                _newDeal.discountType = DiscountType.PERCENTAGE;
                              } else {
                                _newDeal.discountType = DiscountType.ABSOLUTE;
                              }
                            });
                          },
                          child: _newDeal.discountType == DiscountType.ABSOLUTE ? Text('zł') : Text('%'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        child: Text('Dodaj kupon'),
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
