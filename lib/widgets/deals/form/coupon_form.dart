import 'dart:io';

import 'package:BSApp/models/add_deal_model.dart';
import 'package:BSApp/models/custom_exception.dart';
import 'package:BSApp/models/deal_type.dart';
import 'package:BSApp/models/discount_type.dart';
import 'package:BSApp/models/location_type.dart';
import 'package:BSApp/providers/deals.dart';
import 'package:BSApp/screens/common/category_selection_screen.dart';
import 'package:BSApp/services/custom_info.dart';
import 'package:BSApp/util/image_assets_helper.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/util/my_styling_provider.dart';
import 'package:BSApp/widgets/common/form_field_divider.dart';
import 'package:BSApp/widgets/common/form_field_title.dart';
import 'package:BSApp/widgets/common/loading_indicator.dart';
import 'package:BSApp/widgets/common/primary_button.dart';
import 'package:BSApp/widgets/deals/form/image_picker_dialog.dart';
import 'package:BSApp/widgets/deals/form/localisation_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  bool _showInternetOnly;
  bool _isImageButtonDisabled = true;

  @override
  void initState() {
    super.initState();
    _newDeal = widget.newDeal;
    _showInternetOnly = _newDeal.locationType == LocationType.INTERNET;
    _newDeal.discountType = DiscountType.PERCENTAGE;
  }

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
      await infoDialog(
        context,
        title: 'Sukces!',
        textContent: 'Kupon został dodany',
      );
      // Navigator.of(context).pushReplacementNamed(DealsScreen.routeName);
    } on CustomException catch (error) {
      var errorMessage = 'Coś poszło nie tak. Spróbuj później!';
      if (error.toString().contains('Unauthorized')) {
        errorMessage = 'W celu dodania kuponu zaloguj się!';
      }
      await infoDialog(
        context,
        title: 'Błąd podczas dodawania kuponu',
        textContent: errorMessage,
      );
    } catch (error) {
      const errorMessage = 'Coś poszło nie tak. Spróbuj później!';
      await infoDialog(
        context,
        title: 'Błąd',
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
      _newDeal.imageUrl = null;
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
                    const FormFieldDivider(),
                    _titleSection(),
                    const FormFieldDivider(),
                    _descriptionSection(),
                    const FormFieldDivider(),
                    _codeSection(),
                    const FormFieldDivider(),
                    _linkSection(),
                    const FormFieldDivider(),
                    const FormFieldDivider(),
                    _pictureSection(),
                    const FormFieldDivider(),
                    Container(
                      margin: const EdgeInsets.only(left: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Kupon internetowy'),
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
                        const Text('Kupon ważny od: '),
                        Text(
                          "${_newDeal.validFrom.toLocal()}".split(' ')[0],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () => _selectDate(DealDateType.VALID_TO),
                          color: MyColorsProvider.BLUE,
                        ),
                        const Text('Kupon ważny do: '),
                        Text(
                          "${_newDeal.validTo.toLocal()}".split(' ')[0],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                            decoration: MyStylingProvider
                                .textFormFiledDecorationWithLabelText(
                                    'Wartość kuponu'),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              if (_newDeal.discountType ==
                                  DiscountType.ABSOLUTE) {
                                _newDeal.discountType = DiscountType.PERCENTAGE;
                              } else {
                                _newDeal.discountType = DiscountType.ABSOLUTE;
                              }
                            });
                          },
                          child: _newDeal.discountType == DiscountType.ABSOLUTE
                              ? const Text('zł')
                              : const Text('%'),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: PrimaryButton('Dodaj kupon', _submit),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  Widget _titleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FormFieldTitle('Tytuł ogłoszenia*'),
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
      ],
    );
  }

  Widget _linkSection() {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const FormFieldTitle('Link do kuponu'),
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
                    _updateUrl(value);
                  },
                  decoration: MyStylingProvider.textFormFiledDecorationWithLabelText('Link do kuponu'),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: _isImageButtonDisabled ? null : () => _buildImagePickerDialog(context),
            behavior: HitTestBehavior.translucent,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.bottomRight,
              child: Icon(Icons.image_outlined, color: _isImageButtonDisabled ? Colors.grey : MyColorsProvider.DEEP_BLUE,),
              // child: SizedBox(
              //   width: 30.0,
              //   child: Image.asset(
              //     ImageAssetsHelper.imageDownloadPath(),
              //     fit: BoxFit.cover,
              //   ),
              // ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _pictureSection() {
    return GestureDetector(
      onTap: _takePicture,
      child: Container(
        width: double.infinity,
        height: 120,
        alignment: Alignment.center,
        child: _getImage(),
      ),
    );
  }



  Widget _codeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FormFieldTitle('Kod kuponu*'),
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
          decoration: MyStylingProvider
              .textFormFiledDecorationWithLabelText('Kod kuponu'),
        ),
      ],
    );
  }


  Widget _descriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FormFieldTitle('Opis*'),
        TextFormField(
          minLines: 4,
          maxLines: 4,
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
      ],
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
                'Dodaj zdjęcie',
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

  void _selectDate(DealDateType dateType) async {
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
