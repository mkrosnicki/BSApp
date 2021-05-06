import 'package:BSApp/models/custom_exception.dart';
import 'package:BSApp/providers/auth.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/util/my_styling_provider.dart';
import 'package:BSApp/widgets/common/information_dialog.dart';
import 'package:BSApp/widgets/common/loading_indicator.dart';
import 'package:BSApp/widgets/common/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'form_title.dart';

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final Map<String, String> _authData = {'email': '', 'password': '', 'username': ''};
  bool _isLoading = false;

  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  InputDecoration _getFormFieldDecoration(String hintText) {
    return MyStylingProvider.TEXT_FORM_FIELD_DECORATION
        .copyWith(hintText: hintText);
  }

  InputDecoration formFieldDecoration = const InputDecoration(
    enabledBorder: InputBorder.none,
    focusedErrorBorder: InputBorder.none,
    filled: true,
    fillColor: MyColorsProvider.GREY_BORDER_COLOR,
    focusColor: MyColorsProvider.GREY_BORDER_COLOR,
    border: UnderlineInputBorder(
      borderSide: BorderSide(width: 0, style: BorderStyle.none),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(width: 0),
    ),
  );

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    var signUpSuccessful = false;
    try {
      await Provider.of<Auth>(context, listen: false).signup(
        _authData['email'],
        _authData['password'],
        _authData['username'],
      );
      signUpSuccessful = true;
    } on CustomException catch (error) {
      var errorMessage =
          'Rejestracja zakończyła się niepowodzeniem. Spróbuj później!';
      if (error.toString().contains('Email address already in use')) {
        errorMessage = 'Istnieje już konto z podanym emailem!';
      } else if (error
          .toString()
          .contains('must be a well-formed email address')) {
        errorMessage = 'Email został podany w złym formacie!';
      }
      await showInformationDialog(context, const Text('Błąd rejestracji'), Text(errorMessage), const Text('Ok'));
    } catch (error) {
      const errorMessage =
          'Rejestracja zakończyła się niepowodzeniem. Spróbuj później!';
      await showInformationDialog(context, const Text('Błąd rejestracji'), const Text(errorMessage), const Text('Ok'));
    }

    setState(() {
      _isLoading = false;
    });
    if (signUpSuccessful) {
      await showInformationDialog(
          context,
          const Text('Konto zostało utworzone.'),
          const Text(
              'W celu aktywacji konta sprawdź swoją skrzynkę pocztową i potwierdź swój email.'),
          const Text('Ok'));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: LoadingIndicator(),
          )
        : SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const FormTitle('Zarejestruj się'),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6.0),
                      child: TextFormField(
                        controller: _emailController,
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.emailAddress,
                        decoration: _getFormFieldDecoration('E-mail'),
                        validator: (value) {
                          if (value.isEmpty || !value.contains('@')) {
                            return 'Nieprawidłowy e-mail!';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          _authData['email'] = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6.0),
                      child: TextFormField(
                        controller: _nameController,
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.emailAddress,
                        decoration: _getFormFieldDecoration('Imię'),
                        validator: (value) {
                          if (value.length < 3) {
                            return 'Za krótkie imię, wprowadź co najmniej 3 znaki.';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          _authData['username'] = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6.0),
                      child: TextFormField(
                        controller: _passwordController,
                        cursorColor: Colors.black,
                        obscureText: true,
                        decoration: _getFormFieldDecoration('Hasło'),
                        validator: (value) {
                          if (value.length < 3) {
                            return 'Za krótkie hasło!';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          _authData['password'] = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6.0),
                      child: TextFormField(
                        controller: _confirmPasswordController,
                        cursorColor: Colors.black,
                        obscureText: true,
                        decoration: _getFormFieldDecoration('Potwierdź hasło'),
                        validator: (value) {
                          if (value != _passwordController.text) {
                            return 'Hasła nie są takie same!';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          _authData['password'] = value;
                        },
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 6.0),
                      child: PrimaryButton('Stwórz konto', _submit),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
