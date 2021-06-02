import 'dart:io';

import 'package:BSApp/models/add_deal_model.dart';
import 'package:BSApp/models/custom_exception.dart';
import 'package:BSApp/models/deal_type.dart';
import 'package:BSApp/models/location_type.dart';
import 'package:BSApp/providers/deals.dart';
import 'package:BSApp/screens/common/category_selection_screen.dart';
import 'package:BSApp/services/custom_info.dart';
import 'package:BSApp/util/date_util.dart';
import 'package:BSApp/util/image_assets_helper.dart';
import 'package:BSApp/util/my_styling_provider.dart';
import 'package:BSApp/widgets/common/loading_indicator.dart';
import 'package:BSApp/widgets/common/primary_button.dart';
import 'package:BSApp/widgets/deals/form/form_field_divider.dart';
import 'package:BSApp/widgets/deals/form/location_type_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'age_type_chips.dart';
import 'deal_date.dart';
import 'image_picker_dialog.dart';
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

  // bool _showInternetOnly;
  bool _isImageButtonDisabled = true;

  @override
  void initState() {
    super.initState();
    _newDeal = widget.newDeal;
    // _showInternetOnly = _newDeal.locationType == LocationType.INTERNET;
    _newDeal.discountType = null;
  }

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
      await infoDialog(
        context,
        title: 'Sukces!',
        textContent: 'Ogłoszenie zostało dodane',
      );
      // Navigator.of(context).pushReplacementNamed(DealsScreen.routeName);
    } on CustomException catch (error) {
      var errorMessage = 'Coś poszło nie tak. Spróbuj później!';
      if (error.toString().contains('Unauthorized')) {
        errorMessage = 'W celu dodania ogłoszenia zaloguj się!';
      }
      await infoDialog(
        context,
        title: 'Błąd podczas dodawania ogłoszenia',
        textContent: errorMessage,
      );
    } catch (error) {
      const errorMessage = 'Coś poszło nie tak. Spróbuj później!';
      await infoDialog(
        context,
        title: 'Błąd podczas dodawania ogłoszenia',
        textContent: errorMessage,
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
                    _formFieldTitle('Tytuł ogłoszenia*'),
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
                      decoration: MyStylingProvider.textFormFiledDecorationWithLabelText('Tytuł ogłoszenia'),
                    ),
                    const FormFieldDivider(),
                    _formFieldTitle('Opis'),
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
                      decoration: MyStylingProvider.textFormFiledDecorationWithLabelText('Opis'),
                    ),
                    const FormFieldDivider(),
                    Row(
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _formFieldTitle('Link do okazji'),
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
                                  _updateUrl(value);
                                },
                                decoration: MyStylingProvider.textFormFiledDecorationWithLabelText('Link do okazji'),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          // TODO stack transparent?
                          onTap: _isImageButtonDisabled ? null : () => _buildImagePickerDialog(context),
                          behavior: HitTestBehavior.translucent,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 30.0,
                              child: Image.asset(
                                ImageAssetsHelper.imageDownloadPath(),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        // IconButton(
                        //   splashRadius: 25,
                        //   icon: const Icon(
                        //     CupertinoIcons.photo,
                        //   ),
                        //   onPressed: _isImageButtonDisabled
                        //       ? null
                        //       : () => _buildImagePickerDialog(context),
                        // ),
                      ],
                    ),
                    const FormFieldDivider(),
                    GestureDetector(
                      onTap: _takePicture,
                      child: Container(
                        width: double.infinity,
                        height: 120,
                        alignment: Alignment.center,
                        child: _getImage(),
                      ),
                    ),
                    const FormFieldDivider(),
                    LocationTypeSelector(_newDeal.locationType, _changeLocation),
                    // Container(
                    //   margin: const EdgeInsets.only(left: 16),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       const Text('Okazja internetowa'),
                    //       Switch.adaptive(
                    //           activeColor: MyColorsProvider.BLUE,
                    //           value: _newDeal.locationType ==
                    //               LocationType.INTERNET,
                    //           onChanged: (value) {
                    //             _changeLocationOld(value);
                    //           }),
                    //     ],
                    //   ),
                    // ),
                    const FormFieldDivider(),
                    if (!_newDeal.isInternetType)
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
                        enabled: !_newDeal.isInternetType,
                      ),
                    const FormFieldDivider(),
                    if (!_newDeal.isInternetType)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _formFieldTitle('Opis lokalizacji (opcjonalnie)'),
                          TextFormField(
                            initialValue: _newDeal.locationDescription,
                            enabled: !_newDeal.isInternetType,
                            onChanged: (value) {
                              _newDeal.locationDescription = value;
                            },
                            decoration: MyStylingProvider.textFormFiledDecorationWithLabelText('np. koło stacji benzynowej'),
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
                    const FormFieldDivider(),
                    Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: _buildDateSelectionTile(DealDateType.VALID_FROM),
                        ),
                        Flexible(
                          child: _buildDateSelectionTile(DealDateType.VALID_TO),
                        ),
                      ],
                    ),
                    // GestureDetector(
                    //   onTap: () => _selectDate(DealDateType.VALID_FROM),
                    //   child: Container(
                    //     padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    //     child: Row(
                    //       children: <Widget>[
                    //         Padding(
                    //           padding: const EdgeInsets.all(8.0),
                    //           child: SizedBox(
                    //             width: 25.0,
                    //             child: Image.asset(
                    //               ImageAssetsHelper.validFromImagePath(),
                    //               fit: BoxFit.cover,
                    //             ),
                    //           ),
                    //         ),
                    //         // IconButton(
                    //         //   icon: const Icon(Icons.calendar_today),
                    //         //   onPressed: () => _selectDate(DealDateType.VALID_FROM),
                    //         //   color: MyColorsProvider.BLUE,
                    //         // ),
                    //         const Text('Okazja ważna od: '),
                    //         Text(
                    //           "${_newDeal.validFrom.toLocal()}".split(' ')[0],
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // const FormFieldDivider(),
                    // GestureDetector(
                    //   onTap: () => _selectDate(DealDateType.VALID_TO),
                    //   child: Container(
                    //     padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    //     child: Row(
                    //       children: <Widget>[
                    //         Padding(
                    //           padding: const EdgeInsets.all(8.0),
                    //           child: SizedBox(
                    //             width: 25.0,
                    //             child: Image.asset(
                    //               ImageAssetsHelper.validToImagePath(),
                    //               fit: BoxFit.cover,
                    //             ),
                    //           ),
                    //         ),
                    //         // IconButton(
                    //         //   icon: const Icon(Icons.calendar_today),
                    //         //   onPressed: () => _selectDate(DealDateType.VALID_FROM),
                    //         //   color: MyColorsProvider.BLUE,
                    //         // ),
                    //         const Text('Okazja ważna do: '),
                    //         Text(
                    //           "${_newDeal.validTo.toLocal()}".split(' ')[0],
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    const FormFieldDivider(),
                    _formFieldTitle('Regularna cena*'),
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
                      decoration: MyStylingProvider.textFormFiledDecorationWithLabelText('Regularna cena'),
                    ),
                    const FormFieldDivider(),
                    _formFieldTitle('Aktualna cena*'),
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
                      decoration: MyStylingProvider.textFormFiledDecorationWithLabelText('Aktualna cena'),
                    ),
                    const FormFieldDivider(),
                    _formFieldTitle('Koszt dostawy (opcjonalnie)'),
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
                      decoration: MyStylingProvider.textFormFiledDecorationWithLabelText('Koszt dostawy'),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: PrimaryButton('Dodaj ogłoszenie', _submit),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  Widget _getImage() {
    if (_newDeal.image != null) {
      return Image.file(
        _newDeal.image,
        fit: BoxFit.cover,
        width: double.infinity,
      );
    } else if (_newDeal.imageUrl != null && _newDeal.imageUrl.isNotEmpty) {
      return Image.network(
        _newDeal.imageUrl,
        fit: BoxFit.cover,
        width: double.infinity,
      );
    } else {
      return Container(
        color: Colors.yellow.shade50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30.0,
              child: Image.asset(
                ImageAssetsHelper.imageUploadPath(),
                fit: BoxFit.cover,
              ),
            ),
            Container(
              // height: 40.0,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 10.0),
              child: const Text(
                'Dodaj obrazek',
                // textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, height: 1.6),
              ),
            ),
          ],
        ),
      );
    }
  }

  Future<String> _buildImagePickerDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return ImagePickerDialog(_newDeal.urlLocation);
      },
    ).then((value) {
      if (value == null) {
        return;
      }
      final urlFromImagePicker = value as String;
      if (!urlFromImagePicker.isEmpty) {
        setState(() {
          _newDeal.imageUrl = urlFromImagePicker;
          _newDeal.image = null;
        });
      }
    });
  }

  void _updateUrl(String value) {
    _newDeal.urlLocation = value;
    // https://xx.pl -> 13 characters minimum
    if (value.length > 13 && _isUrl(value)) {
      setState(() {
        _isImageButtonDisabled = false;
      });
    } else {
      setState(() {
        _isImageButtonDisabled = true;
      });
    }
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
    final selectedCategories = await Navigator.of(context).pushNamed(CategorySelectionScreen.routeName);
    if (selectedCategories != null) {
      setState(() {
        _newDeal.categories = selectedCategories;
      });
    }
  }

  // void _changeLocationOld(bool value) {
  //   setState(() {
  //     _showInternetOnly = value;
  //     if (_showInternetOnly) {
  //       _newDeal.locationType = LocationType.INTERNET;
  //       _newDeal.clearLocation();
  //     } else {
  //       _newDeal.locationType = LocationType.LOCAL;
  //     }
  //   });
  // }

  void _changeLocation() {
    setState(() {
      _newDeal.locationType =
          _newDeal.locationType == LocationType.INTERNET ? LocationType.LOCAL : LocationType.INTERNET;
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

  Widget _buildDateSelectionTile(DealDateType dateType) {
    return GestureDetector(
      onTap: () => _selectDate(dateType),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: SizedBox(
                width: 27.0,
                child: Image.asset(
                  dateType == DealDateType.VALID_FROM
                      ? ImageAssetsHelper.validFromImagePath()
                      : ImageAssetsHelper.validToImagePath(),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dateType == DealDateType.VALID_FROM ? 'Okazja ważna od' : 'Okazja ważna do',
                  style: const TextStyle(fontSize: 11, color: Colors.grey, height: 1.5),
                ),
                Text(
                  DateUtil.getFormatted(dateType == DealDateType.VALID_FROM ? _newDeal.validFrom : _newDeal.validTo),
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _formFieldTitle(final String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 13, color: Colors.black54),
      ),
    );
  }
}
