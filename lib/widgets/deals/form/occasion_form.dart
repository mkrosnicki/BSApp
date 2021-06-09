import 'dart:io';

import 'package:BSApp/models/add_deal_model.dart';
import 'package:BSApp/models/age_type.dart';
import 'package:BSApp/models/custom_exception.dart';
import 'package:BSApp/models/deal_type.dart';
import 'package:BSApp/models/location_type.dart';
import 'package:BSApp/providers/deals.dart';
import 'package:BSApp/screens/common/category_selection_screen.dart';
import 'package:BSApp/services/custom_info.dart';
import 'package:BSApp/util/date_util.dart';
import 'package:BSApp/util/image_assets_helper.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/util/my_styling_provider.dart';
import 'package:BSApp/widgets/common/form_field_title.dart';
import 'package:BSApp/widgets/common/loading_indicator.dart';
import 'package:BSApp/widgets/common/primary_button.dart';
import 'package:BSApp/widgets/deals/form/deal_form_location_type_selector.dart';
import 'file:///D:/Projects/Flutter/BSApp/lib/widgets/common/form_field_divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'deal_date.dart';
import 'deal_form_age_types_selector.dart';
import 'deal_form_category_selector.dart';
import 'image_picker_dialog.dart';
import 'localisation_selector.dart';

class OccasionForm extends StatefulWidget {
  final AddDealModel newDeal;

  const OccasionForm(this.newDeal);

  @override
  _OccasionFormState createState() => _OccasionFormState();
}

class _OccasionFormState extends State<OccasionForm> {
  static const _formFieldTextStyle = TextStyle(fontSize: 14, color: Colors.black87);

  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _isLoading = false;
  AddDealModel _newDeal;
  final TextEditingController _locationTextController = TextEditingController();

  // bool _showInternetOnly;
  bool _isImageButtonDisabled = true;

  @override
  void initState() {
    super.initState();
    _newDeal = widget.newDeal;
    _newDeal.discountType = null;
    _locationTextController.text = _newDeal.voivodeship != null ? locationString(_newDeal) : 'Cała Polska';
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
                    const FormFieldDivider(),
                    _titleSection(),
                    const FormFieldDivider(),
                    _linkSection(),
                    const FormFieldDivider(),
                    const FormFieldDivider(),
                    _pictureSection(),
                    const FormFieldDivider(),
                    _priceInfoSection(),
                    const FormFieldDivider(),
                    _locationSelectionSection(),
                    const FormFieldDivider(),
                    _categorySelectionSection(),
                    const FormFieldDivider(),
                    _ageTypesSelectionSection(),
                    const FormFieldDivider(),
                    _descriptionSection(),
                    const FormFieldDivider(),
                    const FormFieldDivider(),
                    _dateSelectionButtons(),
                    const FormFieldDivider(),
                    const FormFieldDivider(),
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

  Widget _ageTypesSelectionSection() {
    return DealsFormAgeTypesSelector(_newDeal, _selectAgeTypes);
  }

  void _selectAgeTypes(final List<AgeType> ageTypes) {
    setState(() {
      _newDeal.ageTypes = ageTypes;
    });
  }

  Widget _categorySelectionSection() {
    return DealsFormCategorySelector(
      _newDeal.categories,
      () => _openCategorySelector(context),
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

  Widget _descriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _formFieldTitle('Opis'),
        TextFormField(
          initialValue: _newDeal.description,
          minLines: 4,
          maxLines: 4,
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
          decoration: MyStylingProvider.textFormFiledDecorationWithLabelText(
              'Krótko opisz okazję i napisz, dlaczego jest atrakcyjna 🙂'),
        ),
      ],
    );
  }

  Widget _locationSelectionSection() {
    return Column(
      children: [
        DealsFormLocationTypeSelector(_newDeal.locationType, _changeLocation),
        if (!_newDeal.isInternetType)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const FormFieldDivider(),
              _formFieldTitle('Lokalizacja*'),
              GestureDetector(
                onTap: () => _openLocationSelector(),
                child: TextFormField(
                  enabled: false,
                  controller: _locationTextController,
                  style: _formFieldTextStyle,
                  decoration: MyStylingProvider.textFormFiledDecorationWithLabelText('Wybierz lokalizację*').copyWith(
                    suffixIcon: const Icon(
                      CupertinoIcons.forward,
                      color: MyColorsProvider.DEEP_BLUE,
                    ),
                  ),
                ),
              ),
              const FormFieldDivider(),
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
      ],
    );
  }

  Widget _dateSelectionButtons() {
    return Flex(
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
    );
  }

  Widget _priceInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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

  void _changeLocation() {
    setState(() {
      _newDeal.locationType =
          _newDeal.locationType == LocationType.INTERNET ? LocationType.LOCAL : LocationType.INTERNET;
    });
  }

  Future<void> _openLocationSelector() async {
    FocusScope.of(context).unfocus();
    await openLocationSelector(context, _newDeal);
    _locationTextController.text = _newDeal.voivodeship != null ? locationString(_newDeal) : 'Cała Polska';
    setState(() {});
  }

  bool _isUrl(String value) {
    return Uri.parse(value).isAbsolute;
  }

  Widget _buildDateSelectionTile(DealDateType dateType) {
    return GestureDetector(
      onTap: () => _selectDate(dateType),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
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
                  dateType == DealDateType.VALID_FROM ? 'Ważna od' : 'Ważna do',
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
