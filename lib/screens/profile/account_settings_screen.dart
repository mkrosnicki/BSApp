import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/widgets/bars/app_bar_back_button.dart';
import 'package:BSApp/widgets/bars/base_app_bar.dart';
import 'package:BSApp/widgets/common/form_field_divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountSettingsScreen extends StatefulWidget {
  static const routeName = '/account-settings';

  @override
  _AccountSettingsScreenState createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar(
        leading: AppBarBackButton(Colors.white),
        title: 'Ustawienia konta',
      ),
      backgroundColor: MyColorsProvider.BACKGROUND_COLOR,
      body: false ? Container() : _optionsList(),
    );
  }

  Widget _optionsList() {
    final menuOptions = [
      FormFieldDivider(),
      _sectionTitle('Profil'),
      _optionTile(
        'Ukryj zdjęcie profilowe',
        'Zaznaczenie tej opcji automatycznie usunie Twoje zdjęcie z bazy.',
        false,
        () {},
      ),
      _sectionTitle('Ustawienia e-mail'),
      _optionTile(
        'Nie otrzymuj maili z aplikacji',
        'Blokuje wysyłanie opcjonalnych maili (np. o nowych okazjach)',
        true,
        () {},
      ),
    ];
    return ListView.builder(
      shrinkWrap: true,
      itemCount: menuOptions.length,
      itemBuilder: (context, index) {
        return menuOptions[index];
      },
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 12,
          color: MyColorsProvider.DEEP_BLUE,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _optionTile(String title, String subtitle, bool isChecked, final Function function) {
    return FlatButton(
      padding: EdgeInsets.zero,
      shape: const Border(
        bottom: BorderSide(color: MyColorsProvider.GREY_BORDER_COLOR, width: 0.5),
      ),
      onPressed: () => function(),
      child: ListTile(
        tileColor: Colors.white,
        title: Text(
          title,
          style: const TextStyle(fontSize: 12),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 10),
        ),
        trailing: isChecked
            ? const Icon(
                CupertinoIcons.checkmark,
                color: MyColorsProvider.DEEP_BLUE,
              )
            : Container(width: 0, height: 0,),
        focusColor: Colors.grey,
      ),
    );
  }
}
