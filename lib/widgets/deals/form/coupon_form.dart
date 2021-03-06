import 'dart:io';

import 'package:BSApp/models/add_deal_model.dart';
import 'package:BSApp/models/age_type.dart';
import 'package:BSApp/models/custom_exception.dart';
import 'package:BSApp/models/deal_type.dart';
import 'package:BSApp/models/discount_type.dart';
import 'package:BSApp/models/location_type.dart';
import 'package:BSApp/providers/deals.dart';
import 'package:BSApp/screens/common/category_selection_screen.dart';
import 'package:BSApp/services/custom_confirm.dart';
import 'package:BSApp/services/custom_info.dart';
import 'package:BSApp/util/date_util.dart';
import 'package:BSApp/util/image_assets_helper.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/util/my_styling_provider.dart';
import 'package:BSApp/util/url_helper.dart';
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

import 'deal_date.dart';
import 'deal_form_age_types_selector.dart';
import 'deal_form_category_selector.dart';
import 'deal_form_location_type_selector.dart';

class CouponForm extends StatefulWidget {
  final AddDealModel newDeal;

  const CouponForm(this.newDeal);

  @override
  _CouponFormState createState() => _CouponFormState();
}

class _CouponFormState extends State<CouponForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  static const _formFieldTextStyle = TextStyle(fontSize: 14, color: Colors.black87);
  final TextEditingController _locationTextController = TextEditingController();
  bool _isLoading = false;
  AddDealModel _newDeal;
  bool _isImageButtonDisabled = true;

  @override
  void initState() {
    super.initState();
    _newDeal = widget.newDeal;
    _newDeal.discountType = DiscountType.PERCENTAGE;
    _locationTextController.text = _newDeal.voivodeship != null ? locationString(_newDeal) : 'Ca??a Polska';
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
        textContent: 'Kupon zosta?? dodany',
      );
      // Navigator.of(context).pushReplacementNamed(DealsScreen.routeName);
    } on CustomException catch (error) {
      var errorMessage = 'Co?? posz??o nie tak. Spr??buj p????niej!';
      if (error.toString().contains('Unauthorized')) {
        errorMessage = 'W celu dodania kuponu zaloguj si??!';
      }
      await infoDialog(
        context,
        title: 'B????d podczas dodawania kuponu',
        textContent: errorMessage,
      );
    } catch (error) {
      const errorMessage = 'Co?? posz??o nie tak. Spr??buj p????niej!';
      await infoDialog(
        context,
        title: 'B????d',
        textContent: errorMessage,
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _choosePicture(BuildContext context) async {
    final useCamera = await confirmDialog(
      context,
      textOK: 'U??yj aparatu',
      textCancel: 'Wybierz z galerii',
      title: 'Dodaj zdj??cie',
      textContent: 'W jaki chcesz doda?? zdj??cie?',
    );

    final PickedFile pickedFile = useCamera ? await _takeFromCamera() : await _takeFromGallery();
    if (pickedFile != null) {
      setState(() {
        _newDeal.image = File(pickedFile.path);
        _newDeal.imageUrl = null;
      });
    }

    return Future.value();
  }

  Future<PickedFile> _takeFromCamera() async {
    final imageFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 300,
    );
    return imageFile == null ? Future.value() : Future.value(imageFile);
  }

  Future<PickedFile> _takeFromGallery() async {
    final imageFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 300,
    );
    return imageFile == null ? Future.value() : Future.value(imageFile);
  }

  @override
  Widget build(BuildContext context) {
    _newDeal.discountType ??= DiscountType.PERCENTAGE;
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
                    _codeSection(),
                    const FormFieldDivider(),
                    _discountSection(),
                    const FormFieldDivider(),
                    _locationSelectionSection(),
                    const FormFieldDivider(),
                    _categorySelectionSection(),
                    const FormFieldDivider(),
                    _ageTypesSelectionSection(),
                    const FormFieldDivider(),
                    _descriptionSection(),
                    const FormFieldDivider(),
                    _dateSelectionButtons(),
                    const FormFieldDivider(),
                    const FormFieldDivider(),
                    SafeArea(
                      child: SizedBox(
                        width: double.infinity,
                        child: PrimaryButton('Dodaj kupon', _newDeal.category != null ? _submit : null),
                      ),
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
        const FormFieldTitle('Tytu?? og??oszenia*'),
        TextFormField(
          initialValue: _newDeal.title,
          validator: (value) {
            if (value.isEmpty) {
              return 'Wprowad?? tytu??';
            } else if (value.length < 5) {
              return 'Tytu?? musi mie?? co najmniej 5 znak??w';
            } else {
              return null;
            }
          },
          onChanged: (value) {
            _newDeal.title = value;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: MyStylingProvider.textFormFiledDecorationWithLabelText('Tytu?? og??oszenia'),
        ),
      ],
    );
  }

  Widget _categorySelectionSection() {
    return DealsFormCategorySelector(
      _newDeal.category != null ? [_newDeal.category] : [],
      () => _openCategorySelector(context),
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

  Widget _discountSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FormFieldTitle('Warto???? kuponu*'),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Wprowad?? warto????";
                    } else {
                      if (value.startsWith('-')) {
                        return "Warto???? nie mo??e by?? ujemna";
                      } else if (double.tryParse(value) == null) {
                        return "Warto???? musi by?? liczb??!";
                      } else if (double.parse(value) < 0) {
                        return "Kwota nie mo??e by?? ujemna";
                      } else if (_newDeal.discountType == DiscountType.PERCENTAGE && double.parse(value) > 100) {
                        return "Zni??ka nie mo??e wynosi?? wi??cej ni?? 100%!";
                      } else {
                        return null;
                      }
                    }
                  },
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    _newDeal.discountValue = double.tryParse(value);
                  },
                  onSaved: (value) {
                    _newDeal.discountValue = double.parse(value);
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: MyStylingProvider.textFormFiledDecorationWithLabelText('Warto???? kuponu'),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    if (_newDeal.discountType == DiscountType.ABSOLUTE) {
                      _newDeal.discountType = DiscountType.PERCENTAGE;
                    } else {
                      _newDeal.discountType = DiscountType.ABSOLUTE;
                    }
                    _formKey.currentState.validate();
                  });
                },
                child: Container(
                  alignment: Alignment.topRight,
                  height: 20,
                  padding: const EdgeInsets.only(left: 15.0, right: 8.0, bottom: 4.0, top: 10.0),
                  child: Text(_newDeal.discountType == DiscountType.ABSOLUTE ? 'z??' : '%', style: const TextStyle(fontSize: 18, color: MyColorsProvider.DEEP_BLUE),),
                ),
              ),
            ],
          ),
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
                      return null;
                    } else if (!UrlHelper.isUrl(value)) {
                      return 'Podany ci??g znak??w nie jest adresem URL';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    _updateUrl(value);
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: MyStylingProvider.textFormFiledDecorationWithLabelText('Link do kuponu'),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: _isImageButtonDisabled ? null : () => _buildImagePickerDialog(context),
            behavior: HitTestBehavior.translucent,
            child: Container(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 32.0),
              alignment: Alignment.topRight,
              child: Icon(
                Icons.image_outlined,
                color: _isImageButtonDisabled ? Colors.grey : MyColorsProvider.DEEP_BLUE,
              ),
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
      onTap: () => _choosePicture(context),
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
              return 'Wprowad?? kod kuponu';
            } else if (value.length < 3) {
              return 'Kod powinien mie?? co najmniej 3 znaki.';
            } else {
              return null;
            }
          },
          onChanged: (value) {
            _newDeal.dealCode = value;
          },
          onSaved: (value) {
            _newDeal.dealCode = value;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: MyStylingProvider.textFormFiledDecorationWithLabelText('Kod kuponu'),
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
              const FormFieldTitle('Lokalizacja*'),
              GestureDetector(
                onTap: () => _openLocationSelector(),
                child: TextFormField(
                  enabled: false,
                  controller: _locationTextController,
                  style: _formFieldTextStyle,
                  decoration: MyStylingProvider.textFormFiledDecorationWithLabelText('Wybierz lokalizacj??*').copyWith(
                    suffixIcon: const Icon(
                      CupertinoIcons.forward,
                      color: MyColorsProvider.DEEP_BLUE,
                    ),
                  ),
                ),
              ),
              const FormFieldDivider(),
              const FormFieldTitle('Opis lokalizacji (opcjonalnie)'),
              TextFormField(
                initialValue: _newDeal.locationDescription,
                enabled: !_newDeal.isInternetType,
                onChanged: (value) {
                  _newDeal.locationDescription = value;
                },
                decoration: MyStylingProvider.textFormFiledDecorationWithLabelText('np. ko??o stacji benzynowej'),
              ),
            ],
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
              return 'Wprowad?? opis';
            } else if (value.length < 10) {
              return 'Opis powinien mie?? conajmniej 10 znak??w';
            } else {
              return null;
            }
          },
          onChanged: (value) {
            _newDeal.description = value;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: MyStylingProvider.textFormFiledDecorationWithLabelText(
              'Kr??tko opisz kupon i spos??b, w jaki mo??na go zrealizowa?? ????'),
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
                'Dodaj zdj??cie',
                // textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, height: 1.6),
              ),
            ),
          ],
        ),
      );
    }
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

  Widget _buildDateSelectionTile(DealDateType dateType) {
    final DateTime date = dateType == DealDateType.VALID_FROM ? _newDeal.validFrom : _newDeal.validTo;
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
                  dateType == DealDateType.VALID_FROM ? 'Wa??ny od' : 'Wa??ny do',
                  style: const TextStyle(fontSize: 11, color: Colors.grey, height: 1.5),
                ),
                Text(
                  date != null ? DateUtil.getFormatted(date) : 'Nie wybrano',
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
      if (urlFromImagePicker.isNotEmpty) {
        setState(() {
          _newDeal.imageUrl = urlFromImagePicker;
          _newDeal.image = null;
        });
      }
    });
  }

  void _updateUrl(String value) {
    if (value == null || value.isEmpty) {
      _newDeal.urlLocation = null;
    } else {
      _newDeal.urlLocation = UrlHelper.getWithPrefix(value);
      if (UrlHelper.isUrl(_newDeal.urlLocation)) {
        setState(() {
          _isImageButtonDisabled = false;
        });
      } else {
        setState(() {
          _isImageButtonDisabled = true;
        });
      }
    }
  }

  void _selectDate(DealDateType dateType) async {
    FocusScope.of(context).unfocus();
    await DealDateSelector.selectDateFor(_newDeal, context, dateType);
    setState(() {});
  }

  String get categoriesString {
    return _newDeal.category.name;
  }

  Future<void> _openCategorySelector(BuildContext context) async {
    FocusScope.of(context).unfocus();
    final List selectedCategories = await Navigator.of(context).pushNamed(CategorySelectionScreen.routeName) as List;
    if (selectedCategories != null) {
      setState(() {
        _newDeal.category = selectedCategories.isNotEmpty ? selectedCategories[0] : null;
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
    setState(() {});
  }
}
