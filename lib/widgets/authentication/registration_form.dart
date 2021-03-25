import 'package:BSApp/models/custom_exception.dart';
import 'package:BSApp/models/http_exception.dart';
import 'package:BSApp/providers/auth.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _authData = {'email': '', 'password': '', 'username': ''};
  bool _isLoading = false;

  var _emailController = TextEditingController();
  var _nameController = TextEditingController();
  var _passwordController = TextEditingController();
  var _confirmPasswordController = TextEditingController();

  var formFieldDecoration = InputDecoration(
    enabledBorder: InputBorder.none,
    focusedErrorBorder: InputBorder.none,
    filled: true,
    fillColor: MyColorsProvider.hexToColor('#e4e6e8'),
    focusColor: MyColorsProvider.hexToColor('#e4e6e8'),
    border: UnderlineInputBorder(
      borderSide: const BorderSide(width: 0, style: BorderStyle.none),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: const BorderSide(width: 0),
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
      await _showInformationDialog('Błąd rejestracji', errorMessage);
    } catch (error) {
      const errorMessage =
          'Rejestracja zakończyła się niepowodzeniem. Spróbuj później!';
      await _showInformationDialog('Błąd rejestracji', errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
    if (signUpSuccessful) {
      await _showInformationDialog('Konto zostało utworzone.',
          'W celu aktywacji konta sprawdź swoją skrzynkę pocztową i potwierdź swój email.');
      Navigator.of(context).pop();
    }
  }

  Future<void> _showInformationDialog(String title, String message) async {
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.centerLeft,
                      child: const Text('E-mail'),
                    ),
                    TextFormField(
                      controller: _emailController,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.emailAddress,
                      decoration: formFieldDecoration,
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
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.centerLeft,
                      child: const Text('Twoje imie'),
                    ),
                    TextFormField(
                      controller: _nameController,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.emailAddress,
                      decoration: formFieldDecoration,
                      validator: (value) {
                        if (value.length < 3) {
                          return 'Za krótkie imie, wprowadź conajmnie 3 znaki.';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        _authData['username'] = value;
                      },
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.centerLeft,
                      child: const Text('Hasło'),
                    ),
                    TextFormField(
                      controller: _passwordController,
                      cursorColor: Colors.black,
                      obscureText: true,
                      decoration: formFieldDecoration,
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
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.centerLeft,
                      child: const Text('Potwierdź hasło'),
                    ),
                    TextFormField(
                      controller: _confirmPasswordController,
                      cursorColor: Colors.black,
                      obscureText: true,
                      decoration: formFieldDecoration,
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
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        child: Text('Rejestracja'),
                        onPressed: _submit,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
