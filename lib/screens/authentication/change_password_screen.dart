import 'package:BSApp/models/custom_exception.dart';
import 'package:BSApp/providers/auth.dart';
import 'package:BSApp/util/my_styling_provider.dart';
import 'package:BSApp/widgets/bars/app_bar_back_button.dart';
import 'package:BSApp/widgets/bars/base_app_bar.dart';
import 'package:BSApp/widgets/common/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const routeName = '/change-password';

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _newPasswordController = TextEditingController();
  String _currentPassword = '';
  String _newPassword = '';

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    try {
      await Provider.of<Auth>(context, listen: false).changeUserPassword(_currentPassword, _newPassword);
      await _showDialog('Zmiana hasła', 'Hasło zostało zmienione.');
      Navigator.of(context).pop();
    } on CustomException catch (error) {
      if (error.toString().contains('Old password does not match')) {
        //
        await _showDialog('Błąd podczas zmieniania hasła', 'Podane hasło nie jest obecnym hasłem!');
      }
    } catch (error) {
      const errorMessage = 'Zmiana hasła zakończyła się niepowodzeniem. Spróbuj później.';
      await _showDialog('Błąd podczas zmieniania hasła', errorMessage);
    }
  }

  Future<void> _showDialog(String title, String message) async {
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('Ok'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const BaseAppBar(
        leading: AppBarBackButton(Colors.black),
        title: 'Zmiana hasła',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'Aby zmienić hasło wypełnij poniższy formularz.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: TextFormField(
                            decoration: MyStylingProvider.TEXT_FORM_FIELD_DECORATION.copyWith(hintText: 'Obecne hasło'),
                            obscureText: true,
                            cursorColor: Colors.black,
                            validator: (value) {
                              if (value.isEmpty || value.length < 3) {
                                return 'Zbyt krótkie hasło';
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) {
                              _currentPassword = value;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: TextFormField(
                            decoration: MyStylingProvider.TEXT_FORM_FIELD_DECORATION.copyWith(hintText: 'Nowe hasło'),
                            obscureText: true,
                            cursorColor: Colors.black,
                            controller: _newPasswordController,
                            validator: (value) {
                              if (value.isEmpty || value.length < 3) {
                                return 'Zbyt krótkie hasło';
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) {
                              _newPassword = value;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: TextFormField(
                            decoration:
                                MyStylingProvider.TEXT_FORM_FIELD_DECORATION.copyWith(hintText: 'Potwierdź hasło'),
                            obscureText: true,
                            cursorColor: Colors.black,
                            validator: (value) {
                              if (value != _newPasswordController.text) {
                                return 'Hasła nie są takie same!';
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) {
                              _newPassword = value;
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 2.0),
                          width: double.infinity,
                          child: PrimaryButton(
                            'Zmień hasło',
                            _submit,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
